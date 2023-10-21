
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

class MoveEventField {
  final String path;
  final dynamic value;
  MoveEventField(this.path, this.value);

  Map<String, dynamic> toJson() {
    return {
      "path": path,
      "value": value
    };
  }
}

class EventFilter {

  String? transaction;
  String? package;
  String? moveEventType;
  String? sender;
  MoveModule? moveModule;
  MoveEventModule? moveEventModule;
  MoveEventField? moveEventField;
  TimeRange? timeRange;

  EventFilter({
    this.transaction,
    this.package,
    this.moveEventType,
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
      data.addAll({ "MoveModule": moveEventField!.toJson() });
    }
    if (timeRange != null) {
      data.addAll({ "TimeRange": timeRange!.toJson() });
    }

    return data;
  }

}