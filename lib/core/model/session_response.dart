class Session {
  final String? category;
  final String? description;
  final String? venue;
  final String? level;
  final String? owner;
  final String? ownerEmail;
  final String? scheduledAt;
  final String? scheduledDuration;
  final String? sessionFormat;
  final String? sessionId;
  final String? speaker;
  // final AgendaStatus? status;
  final String? title;
  final String? bgColor;
  final num? order;
  final String? speakerImage;
  final String? speakerTagline;

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
    this.order,
    this.speakerImage,
    this.speakerTagline,
  });

  factory Session.fromJson(Map<String, dynamic> json, {String? bgColor}) =>
      Session(
        title: json['title'],
        category: json['category'],
        speaker: json['owner'],
        speakerImage: json['speakerImage'],
        speakerTagline: json['tagLine'],
        venue: json['hall'],
        description: json['description'],
        level: json['level'],
        owner: json['owner'],
        ownerEmail: json['ownerEmail'],
        scheduledAt: json['scheduledAt'],
        scheduledDuration: json['scheduledDuration'],
        sessionFormat: json['sessionFormat'],
        sessionId: json['sessionId'],
        bgColor: bgColor,
        order: num.tryParse(json['order'].toString()),
      );
}
