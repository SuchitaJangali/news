import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/model/news_article.dart';
import 'package:news/screens/list_news/new_list_view_model.dart'
    show NewsProvider;
import 'package:news/uitils/base_app_notifer.dart' show NotifierState;
import 'package:provider/provider.dart';

class Article extends StatelessWidget {
  static String route = "NewsListScreen";
  final NewsArticle article;
  const Article({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              article.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  article.publishedAt,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
