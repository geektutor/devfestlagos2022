class Schedule {
  String? schedule;
  String? time;
  String? duration;
  String? facilitator;
  int? order;
  bool? isbreakout;
  List<BreakoutSession>? sessions;

  Schedule({
    this.schedule,
    this.time,
    this.duration,
    this.facilitator,
    this.order,
    this.isbreakout,
    this.sessions,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    schedule = json['schedule'];
    time = json['time'];
    duration = json['duration'];
    facilitator = json['facilitator'];
    order = json['order'];
    isbreakout = json['isbreakout'];
    if (json['sessions'] != null) {
      sessions = <BreakoutSession>[];
      json['sessions'].forEach((v) {
        sessions!.add(BreakoutSession.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule'] = schedule;
    data['time'] = time;
    data['duration'] = duration;
    data['facilitator'] = facilitator;
    data['order'] = order;
    data['isbreakout'] = isbreakout;
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BreakoutSession {
  String? schedule;
  String? venue;
  String? facilitator;
  String? time;

  BreakoutSession({this.schedule, this.venue, this.facilitator, this.time});

  BreakoutSession.fromJson(Map<String, dynamic> json) {
    schedule = json['schedule'];
    venue = json['venue'];
    facilitator = json['facilitator'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schedule'] = schedule;
    data['venue'] = venue;
    data['facilitator'] = facilitator;
    data['time'] = time;
    return data;
  }
}
