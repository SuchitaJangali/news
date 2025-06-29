import 'package:flutter/material.dart';
import 'package:news/screens/list_news/new_list_view_model.dart' show NewsProvider;
import 'package:news/uitils/base_app_notifer.dart' show NotifierState;
import 'package:provider/provider.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    if (newsProvider.state == NotifierState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (newsProvider.state == NotifierState.error) {
      return Center(child: Text(newsProvider.errorMessage ?? 'Unknown error'));
    } else if (newsProvider.state == NotifierState.loaded) {
      return ListView.builder(
        itemCount: newsProvider.articles.length,
        itemBuilder: (context, index) {
          final article = newsProvider.articles[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(article.description),
          );
        },
      );
    } else {
      return Center(
        child: ElevatedButton(
          onPressed: () {
            newsProvider.fetchNews(query: 'politics)');
          },
          child: Text('Load News'),
        ),
      );
    }
  }
}
