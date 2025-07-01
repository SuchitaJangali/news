class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String sourceName;
  final String author;
  final String publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.sourceName,
    required this.author,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      sourceName: json['source']['name'] ?? '',
      author: json['author'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
