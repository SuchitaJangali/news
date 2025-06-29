import 'package:news/api/api_service.dart' show ApiService;
import 'package:news/model/news_article.dart' show NewsArticle;
import 'package:news/uitils/base_app_notifer.dart' ;


class NewsProvider extends BaseAppNotifier {
  final ApiService _apiService = ApiService(baseUrl: 'https://newsapi.org/v2/');

  List<NewsArticle> _articles = [];
  List<NewsArticle> get articles => _articles;

  Future<void> fetchNews({String query = 'flutter'}) async {
    state=NotifierState.loading;

    try {
      final response = await _apiService.get(
        'everything',
        queryParams: {
          'q': query,
          'apiKey': 'YOUR_API_KEY',  // Replace with your API key
        },
      );

      final List<dynamic> articlesJson = response['articles'] ?? [];

      _articles = articlesJson
          .map((json) => NewsArticle.fromJson(json))
          .toList();
      state=NotifierState.loaded;
    } catch (e) {
      setState(NotifierState.error, errorMessage: 'Failed to load news: $e');
    }
  }
}
