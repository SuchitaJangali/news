import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/model/news_article.dart';
import 'package:news/screens/home_screen/list_news/new_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle? article;
  const NewsDetailScreen({super.key, this.article});
  static const String route = "NewsDetailScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Channel Info
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      article?.title[0] ?? "",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 40,
                    width: 2,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy')
                                .format(DateTime.parse(article!.publishedAt)) ??
                            '22 May 2020',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        article?.sourceName ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              _highlightText(article?.title ?? "",
                  context.read<NewsProvider>().selectedCategory),

              SizedBox(height: 16),
              _highlightText(article?.description ?? "",
                  context.read<NewsProvider>().selectedCategory),

              // Description
              SizedBox(height: 16),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Read Story',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4),
                        height: 2,
                        width: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Share.share(
                        '${article?.title}\n\n${article?.description}\n\nSource: ${article?.sourceName}',
                      );
                    },
                    child: Text(
                      'Share Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Bottom Image (Dummy Placeholder)
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: article?.imageUrl ?? "",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // Function to highlight search word with red underline
  Widget _highlightText(String fullText, String? searchWord) {
    if (searchWord == null ||
        searchWord.isEmpty ||
        !fullText.toLowerCase().contains(searchWord.toLowerCase())) {
      return Text(
        fullText,
        style: TextStyle(fontSize: 16, height: 1.5),
      );
    }

    List<TextSpan> spans = [];
    String lowerText = fullText.toLowerCase();
    String lowerSearch = searchWord.toLowerCase();

    int start = 0;
    int index;

    while ((index = lowerText.indexOf(lowerSearch, start)) != -1) {
      if (index > start) {
        spans.add(TextSpan(text: fullText.substring(start, index)));
      }
      spans.add(TextSpan(
        text: fullText.substring(index, index + searchWord.length),
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationThickness: 2,
        ),
      ));
      start = index + searchWord.length;
    }

    if (start < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(start)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
        children: spans,
      ),
    );
  }
}
