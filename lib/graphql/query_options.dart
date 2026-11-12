/// Optional filters are combined by the GraphQL indexer with logical AND.
class GraphQLTransactionFilter {
  const GraphQLTransactionFilter({
    this.sentAddress,
    this.affectedAddress,
    this.affectedObject,
    this.function,
    this.kind,
    this.atCheckpoint,
    this.afterCheckpoint,
    this.beforeCheckpoint,
  });
  final String? sentAddress;
  final String? affectedAddress;
  final String? affectedObject;
  final String? function;
  final GraphQLTransactionKind? kind;
  final int? atCheckpoint;
  final int? afterCheckpoint;
  final int? beforeCheckpoint;

  Map<String, Object> toJson() => {
    if (sentAddress != null) 'sentAddress': sentAddress!,
    if (affectedAddress != null) 'affectedAddress': affectedAddress!,
    if (affectedObject != null) 'affectedObject': affectedObject!,
    if (function != null) 'function': function!,
    if (kind != null)
      'kind': kind == GraphQLTransactionKind.system
          ? 'SYSTEM_TX'
          : 'PROGRAMMABLE_TX',
    if (atCheckpoint != null) 'atCheckpoint': atCheckpoint!,
    if (afterCheckpoint != null) 'afterCheckpoint': afterCheckpoint!,
    if (beforeCheckpoint != null) 'beforeCheckpoint': beforeCheckpoint!,
  };
}

enum GraphQLTransactionKind { system, programmable }

class GraphQLEventFilter {
  const GraphQLEventFilter({
    this.module,
    this.type,
    this.sender,
    this.atCheckpoint,
    this.afterCheckpoint,
    this.beforeCheckpoint,
  });
  final String? module;
  final String? type;
  final String? sender;
  final int? atCheckpoint;
  final int? afterCheckpoint;
  final int? beforeCheckpoint;
  Map<String, Object> toJson() {
    if (module != null && type != null) {
      throw ArgumentError(
        'The GraphQL indexer cannot combine module and type filters',
      );
    }
    return {
      if (module != null) 'module': module!,
      if (type != null) 'type': type!,
      if (sender != null) 'sender': sender!,
      if (atCheckpoint != null) 'atCheckpoint': atCheckpoint!,
      if (afterCheckpoint != null) 'afterCheckpoint': afterCheckpoint!,
      if (beforeCheckpoint != null) 'beforeCheckpoint': beforeCheckpoint!,
    };
  }
}

/// Items are ordered in the requested direction. Feed [cursor] into `after`
/// for ascending scans or `before` for descending scans.
class GraphQLPage<T> {
  GraphQLPage({
    required Iterable<T> items,
    required this.hasNextPage,
    this.cursor,
  }) : items = List.unmodifiable(items);
  final List<T> items;
  final bool hasNextPage;
  final String? cursor;
}
