
class NewsArticle {
  final String title;
  final String description;

  NewsArticle({required this.title, required this.description});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
