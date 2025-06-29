import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/news_provider.dart';
// import 'screens/news_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: NewsListScreen(),
      ),
    );
  }
}
