class Prayer {
  final String id;
  final String title;
  final String description;
  final String audioUrl;
  final String speaker;
  final String createdAt;

  Prayer({
    required this.id,
    required this.title,
    required this.description,
    required this.audioUrl,
    required this.speaker,
    required this.createdAt,
  });

  // Factory constructor to create a Prayer instance from JSON
  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      audioUrl: json['audio'],
      speaker: json['speaker'],
      createdAt: json['createdAt'],
    );
  }
}
