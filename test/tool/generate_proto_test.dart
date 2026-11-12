@TestOn('vm && !windows')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final ignored in [false, true]) {
    test(
      'pinned generation rejects ${ignored ? 'ignored' : 'untracked'} proto sources',
      () async {
        final root = await Directory.systemTemp.createTemp('sui-proto-check-');
        addTearDown(() => root.delete(recursive: true));
        final repo = Directory('${root.path}/apis');
        final proto = Directory('${repo.path}/proto/sui/rpc/v2')
          ..createSync(recursive: true);
        final bin = Directory('${root.path}/bin')..createSync();
        Future<ProcessResult> git(List<String> arguments) =>
            Process.run('git', ['-C', repo.path, ...arguments]);
        expect((await git(['init', '--quiet'])).exitCode, 0);
        File(
          '${proto.path}/tracked.proto',
        ).writeAsStringSync('syntax = "proto3";');
        if (ignored) {
          File('${repo.path}/.gitignore').writeAsStringSync('extra.proto\n');
        }
        expect((await git(['add', '.'])).exitCode, 0);
        expect(
          (await git([
            '-c',
            'user.name=SDK test',
            '-c',
            'user.email=sdk@example.test',
            'commit',
            '--quiet',
            '-m',
            'fixture',
          ])).exitCode,
          0,
        );
        File(
          '${proto.path}/extra.proto',
        ).writeAsStringSync('syntax = "proto3";');
        final protoc = File('${bin.path}/protoc')
          ..writeAsStringSync('#!/bin/sh\necho UNEXPECTED_PROTOC\nexit 99\n');
        final dart = File('${bin.path}/dart')
          ..writeAsStringSync('#!/bin/sh\necho "protoc_plugin 22.4.0"\n');
        expect(
          (await Process.run('chmod', ['+x', protoc.path, dart.path])).exitCode,
          0,
        );
        final result = await Process.run(
          'bash',
          ['tool/generate_proto.sh'],
          environment: {
            ...Platform.environment,
            'PATH': '${bin.path}:${Platform.environment['PATH']}',
            'SUI_APIS_DIR': repo.path,
            'SUI_APIS_REF': 'HEAD',
          },
        );
        expect(result.exitCode, 1);
        expect(result.stdout, contains('untracked files'));
        expect(result.stdout, isNot(contains('UNEXPECTED_PROTOC')));
      },
    );
  }
}
