import 'package:devfest/core/model/category_response.dart';
import 'package:devfest/core/model/speakers_response.dart';
import 'package:devfest/core/model/venue_response.dart';

class Session {
  final Category? category;
  final String? description;
  final Hall? venue;
  final String? level;
  final String? owner;
  final String? ownerEmail;
  final String? scheduledAt;
  final String? scheduledDuration;
  final String? sessionFormat;
  final String? sessionId;
  final Speaker? speaker;
  // final AgendaStatus? status;
  final String? title;
  final String? bgColor;

  const Session({
    this.category,
    this.description,
    this.venue,
    this.level,
    this.owner,
    this.ownerEmail,
    this.scheduledAt,
    this.scheduledDuration,
    this.sessionFormat,
    this.sessionId,
    this.speaker,
    // this.status,
    this.title,
    this.bgColor,
  });

  factory Session.fromJson(Map<String, dynamic> json,
          {Speaker? speaker,
          Category? category,
          Hall? venue,
          String? bgColor}) =>
      Session(
        title: json['title'],
        category: category,
        speaker: speaker,
        venue: venue,
        description: json['description'],
        level: json['level'],
        owner: json['owner'],
        ownerEmail: json['ownerEmail'],
        scheduledAt: json['scheduledAt'],
        scheduledDuration: json['scheduledDuration'],
        sessionFormat: json['sessionFormat'],
        sessionId: json['sessionId'],
        bgColor: bgColor,
      );
}
