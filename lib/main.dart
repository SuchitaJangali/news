import 'package:flutter/material.dart';
import 'package:news/model/news_article.dart';
import 'package:news/screens/detail_news/detail_news_screen.dart';
import 'package:news/screens/home_screen/home_screen.dart';
import 'package:news/screens/home_screen/list_news/new_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NewsHomePage(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => NewsHomePage());

              case NewsDetailScreen.route:
                final data = settings.arguments as NewsArticle;
                return MaterialPageRoute(
                    builder: (_) => NewsDetailScreen(
                          article: data,
                        ));

              default:
                return MaterialPageRoute(
                  builder: (_) => Scaffold(
                    body: Center(child: Text('404 - Page not found')),
                  ),
                );
            }
          }),
    );
  }
}
