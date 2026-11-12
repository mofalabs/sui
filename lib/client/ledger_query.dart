import '../grpc/proto/sui/rpc/v2/filter.pb.dart' as pb;
import '../grpc/proto/sui/rpc/v2/query_options.pb.dart';

export '../grpc/proto/sui/rpc/v2/filter.pb.dart'
    show
        TransactionTerm,
        TransactionLiteral,
        EventTerm,
        EventLiteral,
        SenderFilter,
        AffectedAddressFilter,
        AffectedObjectFilter,
        MoveCallFilter,
        EmitModuleFilter,
        EventTypeFilter,
        EventStreamHeadFilter,
        PackageWriteFilter;
export '../grpc/proto/sui/rpc/v2/query_options.pbenum.dart' show QueryEndReason;

typedef GrpcTransactionFilter = pb.TransactionFilter;
typedef GrpcEventFilter = pb.EventFilter;

/// A bounded ledger scan. An empty page can still advance [cursor].
/// Resume with this cursor even when a filtered scan reaches its work limit.
class LedgerPage<T> {
  LedgerPage({
    required Iterable<T> items,
    required this.cursor,
    required this.hasNextPage,
    required this.endReason,
    this.checkpoint,
  }) : items = List.unmodifiable(items);

  final List<T> items;

  /// Base64 cursor; use as `after` for ascending or `before` for descending.
  final String? cursor;
  final bool hasNextPage;
  final BigInt? checkpoint;
  final QueryEndReason endReason;
}
