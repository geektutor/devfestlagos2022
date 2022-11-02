import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest/core/model/category_response.dart';
import 'package:devfest/core/model/speakers_response.dart';
import 'package:devfest/core/model/venue_response.dart';
import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';

class Session {
  final Category? category;
  final DateTime? endTime;
  final Speaker? speaker;
  final DateTime? startTime;
  final AgendaStatus? status;
  final String? title;
  final Hall? venue;

  const Session({
    this.category,
    this.endTime,
    this.speaker,
    this.startTime,
    this.status,
    this.title,
    this.venue,
  });

  factory Session.fromJson(Map<String, dynamic> json,
          {Speaker? speaker, Category? category, Hall? venue}) =>
      Session(
        endTime: (json['endTime'] as Timestamp?)?.toDate(),
        startTime: (json['startTime'] as Timestamp?)?.toDate(),
        status: (json['status'] as String?).agendaStatus,
        title: json['title'],
        category: category,
        speaker: speaker,
        venue: venue,
      );
}
