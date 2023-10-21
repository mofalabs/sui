
class MoveModule {
  final String package;
  final String module;
  MoveModule(this.package, this.module);

  Map<String, String> toJson() {
    return {
      "package": package,
      "module": module
    };
  }
}

class MoveEventModule extends MoveModule {
  final String event;
  MoveEventModule(String package, String module, this.event)
    :super(package, module);

  @override
  Map<String, String> toJson() {
    final data = super.toJson();
    data.addAll({ "event": event });
    return data;
  }
}

class TimeRange {
  final int startTime;
  final int endTime;
  TimeRange(this.startTime, this.endTime);

  Map<String, int> toJson() {
    return {
      "start_time": startTime,
      "end_time": endTime
    };
  }
}

class EventFilter {

  String? transaction;
  String? package;
  String? moveEventType;
  String? senderAddress;
  String? sender;
  MoveModule? moveModule;
  MoveEventModule? moveEventModule;
  Map<String, String>? moveEventField;
  TimeRange? timeRange;

  EventFilter({
    this.transaction,
    this.package,
    this.moveEventType,
    this.senderAddress,
    this.sender,
    this.moveModule,
    this.moveEventModule,
    this.moveEventField,
    this.timeRange,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (transaction != null) {
      data.addAll({ "Transaction": transaction! });
    }
    if (package != null) {
      data.addAll({ "Package": package! });
    }
    if (moveEventType != null) {
      data.addAll({ "MoveEventType": moveEventType! });
    }
    if (senderAddress != null) {
      data.addAll({ "SenderAddress": senderAddress! });
    }
    if (sender != null) {
      data.addAll({ "Sender": sender! });
    }
    if (moveModule != null) {
      data.addAll({ "MoveModule": moveModule!.toJson() });
    }
    if (moveEventModule != null) {
      data.addAll({ "MoveModule": moveEventModule!.toJson() });
    }
    if (moveEventField != null) {
      data.addAll({ "MoveModule": moveEventField! });
    }
    if (timeRange != null) {
      data.addAll({ "TimeRange": timeRange!.toJson() });
    }

    return data;
  }

}