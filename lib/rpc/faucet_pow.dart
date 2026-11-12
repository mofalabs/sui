import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:pointycastle/export.dart'
    show Argon2BytesGenerator, Argon2Parameters;

import '../types/common.dart';

final _u64Limit = BigInt.one << 64;

/// The v1 PoW parameters are fixed; a faucet cannot choose client memory costs.
class FaucetChallenge {
  FaucetChallenge._(this._json);
  final Map<String, dynamic> _json;

  factory FaucetChallenge.fromJson(Map<String, dynamic> json) {
    const fixed = {
      'version': 1,
      'domain': 'sui-faucet-pow/1',
      'algorithm': 'argon2d',
      'argon2Version': 19,
      'salt': 'sui-faucet-pow-1',
      'memorySize': 8192,
      'iterations': 1,
      'parallelism': 1,
      'hashLength': 32,
    };
    for (final entry in fixed.entries) {
      if (json[entry.key] != entry.value) {
        throw FormatException('Unsupported faucet challenge ${entry.key}');
      }
    }
    for (final name in ['chainId', 'checkpointDigest']) {
      _validateDigest(json[name]);
    }
    for (final name in [
      'checkpointSeq',
      'difficulty',
      'threshold',
      'amountMist',
    ]) {
      _parseU64(json[name]);
    }
    final difficulty = _parseU64(json['difficulty']);
    if (difficulty < BigInt.two ||
        difficulty > (BigInt.one << 48) ||
        _parseU64(json['threshold']) != _u64Limit ~/ difficulty ||
        _parseU64(json['amountMist']) == BigInt.zero) {
      throw const FormatException(
        'Invalid faucet difficulty, threshold or amount',
      );
    }
    for (final name in ['faucetAddress', 'recipient']) {
      if (json[name] is! String ||
          !RegExp(r'^0x[0-9a-f]{64}$').hasMatch(json[name] as String)) {
        throw FormatException('Invalid faucet $name');
      }
    }
    final random = json['randomBytes'];
    if (random is! String ||
        random.length > 1024 ||
        !RegExp(
          r'^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$',
        ).hasMatch(random)) {
      throw const FormatException('Invalid faucet randomness');
    }
    final seconds = json['windowSeconds'];
    if (seconds is! int || seconds < 1) {
      throw const FormatException('Invalid faucet window');
    }
    return FaucetChallenge._(Map.unmodifiable(json));
  }

  String get recipient => _json['recipient'] as String;
  String get checkpointSeq => _json['checkpointSeq'] as String;
  int get windowSeconds => _json['windowSeconds'] as int;
  BigInt get threshold => BigInt.parse(_json['threshold'] as String);

  String preimage(BigInt nonce) {
    if (nonce.isNegative || nonce >= _u64Limit) {
      throw ArgumentError.value(nonce, 'nonce');
    }
    return [
      _json['domain'],
      _json['chainId'],
      checkpointSeq,
      _json['checkpointDigest'],
      _json['randomBytes'],
      _json['faucetAddress'],
      recipient,
      nonce.toString(),
    ].join('\n');
  }

  /// Uses a worker isolate on native platforms and the web implementation on web.
  Future<Uint8List> hashProof(BigInt nonce) =>
      compute(_hashProof, preimage(nonce));
}

Uint8List _hashProof(String preimage) {
  final generator = Argon2BytesGenerator()
    ..init(
      Argon2Parameters(
        Argon2Parameters.ARGON2_d,
        Uint8List.fromList(utf8.encode('sui-faucet-pow-1')),
        version: Argon2Parameters.ARGON2_VERSION_13,
        memory: 8192,
        iterations: 1,
        lanes: 1,
        desiredKeyLength: 32,
      ),
    );
  return generator.process(Uint8List.fromList(utf8.encode(preimage)));
}

BigInt _parseU64(dynamic value) {
  if (value is! String || !RegExp(r'^(0|[1-9][0-9]{0,19})$').hasMatch(value)) {
    throw const FormatException('Expected a decimal u64 string');
  }
  final number = BigInt.parse(value);
  if (number >= _u64Limit) throw const FormatException('Value exceeds u64');
  return number;
}

void _validateDigest(dynamic value) {
  if (value is! String ||
      value.length > 44 ||
      base58Decode(value).length != 32) {
    throw const FormatException('Invalid faucet transaction digest');
  }
}

class FaucetV3Response {
  FaucetV3Response._({
    required this.digest,
    required this.recipient,
    required this.amountMist,
    required this.difficulty,
  });
  final String digest;
  final String recipient;
  final BigInt amountMist;
  final BigInt difficulty;

  factory FaucetV3Response.fromJson(Map<String, dynamic> json) {
    _validateDigest(json['digest']);
    final amount = _parseU64(json['amountMist']);
    final difficulty = _parseU64(json['difficulty']);
    if (json['status'] != 'success' ||
        amount == BigInt.zero ||
        difficulty < BigInt.two ||
        difficulty > (BigInt.one << 48) ||
        json['recipient'] is! String ||
        !RegExp(r'^0x[0-9a-f]{64}$').hasMatch(json['recipient'] as String)) {
      throw const FormatException('Invalid faucet payout response');
    }
    return FaucetV3Response._(
      digest: json['digest'] as String,
      recipient: json['recipient'] as String,
      amountMist: amount,
      difficulty: difficulty,
    );
  }
}

class FaucetException implements Exception {
  const FaucetException(
    this.message, {
    required this.status,
    this.code,
    this.digest,
  });
  final String message;
  final int status;
  final String? code;

  /// A payout might already have been submitted when this is present.
  final String? digest;
  @override
  String toString() =>
      'FaucetException($status${code == null ? '' : ', $code'}): $message';
}

/// Fetches a challenge, solves it and submits exactly one payout request.
Future<FaucetV3Response> requestFaucetV3(
  String endpoint,
  String address, {
  Dio? dio,
  CancelToken? cancelToken,
  Duration timeout = const Duration(minutes: 3),
  Map<String, String> headers = const {},
}) async {
  if (address.replaceFirst(RegExp(r'^0x', caseSensitive: false), '').isEmpty) {
    throw ArgumentError.value(address, 'recipient');
  }
  final recipient = normalizeSuiAddress(address);
  if (!isValidSuiAddress(recipient)) {
    throw ArgumentError.value(address, 'recipient');
  }
  if (timeout <= Duration.zero) throw ArgumentError.value(timeout, 'timeout');
  final http = dio ?? Dio();
  final ownsClient = dio == null;
  final token = CancelToken();
  final started = Stopwatch()..start();
  final timer = Timer(
    timeout,
    () => token.cancel(TimeoutException('Faucet request timed out', timeout)),
  );
  if (cancelToken?.isCancelled ?? false) token.cancel(cancelToken!.cancelError);
  unawaited(cancelToken?.whenCancel.then(token.cancel) ?? Future<void>.value());
  void checkCancelled() {
    if (token.isCancelled) {
      final reason = token.cancelError?.error;
      if (reason is TimeoutException) throw reason;
      throw token.cancelError!;
    }
  }

  Future<Map<String, dynamic>> request(
    String path, [
    Map<String, dynamic>? body,
  ]) async {
    checkCancelled();
    final Response<dynamic> response;
    try {
      response = await http.request<dynamic>(
        Uri.parse(endpoint).resolve(path).toString(),
        data: body,
        cancelToken: token,
        options: Options(
          method: body == null ? 'GET' : 'POST',
          headers: headers,
          contentType: 'application/json',
          validateStatus: (_) => true,
        ),
      );
    } on DioException {
      checkCancelled();
      rethrow;
    }
    checkCancelled();
    final data = response.data;
    if ((response.statusCode ?? 500) >= 400) {
      throw FaucetException(
        data is Map && data['error'] is String
            ? data['error'] as String
            : 'Faucet request failed',
        status: response.statusCode ?? 500,
        code: data is Map && data['code'] is String
            ? data['code'] as String
            : null,
        digest: data is Map && data['digest'] is String
            ? data['digest'] as String
            : null,
      );
    }
    if (data is! Map) {
      throw const FormatException('Invalid faucet JSON response');
    }
    return Map<String, dynamic>.from(data);
  }

  try {
    final random = Random.secure();
    while (true) {
      final challengeStart = started.elapsed;
      final challenge = FaucetChallenge.fromJson(
        await request('/v3/challenge?recipient=$recipient'),
      );
      if (challenge.recipient != recipient) {
        throw const FormatException('Faucet challenge recipient mismatch');
      }
      final deadline =
          challengeStart +
          Duration(milliseconds: challenge.windowSeconds * 800);
      var nonce =
          (BigInt.from(random.nextInt(0x100000000)) << 32) |
          BigInt.from(random.nextInt(0x100000000));
      while (started.elapsed < deadline) {
        checkCancelled();
        final hash = await Future.any([
          challenge.hashProof(nonce),
          token.whenCancel.then<Uint8List>((_) {
            checkCancelled();
            throw StateError('Cancelled');
          }),
        ]);
        await Future<void>.delayed(Duration.zero);
        checkCancelled();
        if (started.elapsed >= deadline) break;
        final first = hash
            .take(8)
            .fold(
              BigInt.zero,
              (BigInt value, byte) => (value << 8) | BigInt.from(byte),
            );
        if (first < challenge.threshold) {
          final result = FaucetV3Response.fromJson(
            await request('/v3/gas', {
              'recipient': recipient,
              'checkpointSeq': challenge.checkpointSeq,
              'nonce': nonce.toString(),
              'hashHex': hexEncode(hash),
            }),
          );
          if (result.recipient != recipient) {
            throw const FormatException('Faucet response recipient mismatch');
          }
          return result;
        }
        nonce = (nonce + BigInt.one) % _u64Limit;
      }
    }
  } finally {
    timer.cancel();
    started.stop();
    if (ownsClient) http.close();
  }
}
