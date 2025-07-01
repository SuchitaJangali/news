import 'package:news/api/api_service.dart' show ApiService;
import 'package:news/model/news_article.dart' show NewsArticle;
import 'package:news/uitils/base_app_notifer.dart';

class NewsProvider extends BaseAppNotifier {
  final ApiService _apiService = ApiService(baseUrl: 'https://newsapi.org/v2/');

  String _selectedCategory = "Politics";
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;

  List<NewsArticle> _articles = [];
  List<NewsArticle> get articles => _articles;

  Future<void> fetchNews({String? query = "Politics"}) async {
    _selectedCategory = query ?? _selectedCategory;
    state = NotifierState.loading;
    print("String $query");
    try {
      final response = await _apiService.get(
        'everything?q=$query&sortBy=publishedAt&apiKey=cad6037116e04d5b8494123ede421ef0',
        // queryParams: {
        //   'q': query,
        //   'apiKey': 'cad6037116e04d5b8494123ede421ef0',  // Replace with your API key
        // },
      );
      state = NotifierState.loaded;
      print(" response['articles']${response['articles']}");
      final List<dynamic> articlesJson = response['articles'] ?? [];
      _articles =
          articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } catch (e) {
      setState(NotifierState.error, errorMessage: 'Failed to load news: $e');
    }
  }
}
