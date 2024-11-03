
class Article {
  final String id;
  final String title;
  final String content;
  final String source;
  final DateTime createdAt; // Store as DateTime for easy manipulation

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.source,
    required this.createdAt, // Use DateTime type
  });

  // This method formats the createdAt to a user-friendly string in Arabic

  String getFormattedDate() {
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    if (difference.inSeconds < 60) {
      return difference.inSeconds == 1
          ? 'منذ ثانية واحدة'
          : 'منذ ${difference.inSeconds} ثوانٍ';
    } else if (difference.inMinutes < 60) {
      return difference.inMinutes == 1
          ? 'منذ دقيقة واحدة'
          : 'منذ ${difference.inMinutes} دقائق';
    } else if (difference.inHours < 24) {
      return difference.inHours == 1
          ? 'منذ ساعة واحدة'
          : 'منذ ${difference.inHours} ساعات';
    } else if (difference.inDays < 7) {
      return difference.inDays == 1
          ? 'منذ يوم واحد'
          : 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? 'منذ أسبوع واحد' : 'منذ $weeks أسابيع';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return months == 1 ? 'منذ شهر واحد' : 'منذ $months أشهر';
    } else {
      int years = (difference.inDays / 365).floor();
      return years == 1 ? 'منذ سنة واحدة' : 'منذ $years سنوات';
    }
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    // Parse the original date string and store it as DateTime
    DateTime dateTime = DateTime.parse(json['createdAt']);

    return Article(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      source: json['source'],
      createdAt: dateTime, // Use DateTime object
    );
  }
}
