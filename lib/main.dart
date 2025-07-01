import 'package:flutter/material.dart';
import 'package:news/screens/home_screen/home_screen.dart';
import 'package:news/screens/list_news/new_list_screens.dart';
import 'package:news/screens/list_news/new_list_view_model.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
// import 'providers/news_provider.dart';
// import 'screens/news_list_screen.dart';

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
      ),
    );
  }
}
