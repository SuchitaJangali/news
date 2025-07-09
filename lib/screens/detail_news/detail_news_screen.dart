import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/model/news_article.dart';
import 'package:news/screens/home_screen/list_news/new_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle? article;
  const NewsDetailScreen({super.key, this.article});
  static const String route = "NewsDetailScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              // Channel Info
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Text(
                      article?.sourceName[0] ?? "",
                      style: GoogleFonts.poppins(
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
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        article?.sourceName ?? "",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              _highlightText(article?.title ?? "",
                  context.read<NewsProvider>().selectedCategory,
                  isBold: true),

              SizedBox(height: 16),
              _highlightText(article?.description ?? "",
                  context.read<NewsProvider>().selectedCategory),

              // Description
              SizedBox(height: 16),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => openInAppBrowser(article?.url ?? ""),
                        child: Text(
                          'Read Story',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 4),
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
                      style: GoogleFonts.poppins(
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
  Widget _highlightText(String fullText, String? searchWord,
      {bool isBold = false}) {
    if (searchWord == null ||
        searchWord.isEmpty ||
        !fullText.toLowerCase().contains(searchWord.toLowerCase())) {
      return Text(
        fullText,
        style: GoogleFonts.poppins(
          fontSize: 16,
          height: 1.5,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
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
        style: GoogleFonts.poppins(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
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
        style:
            GoogleFonts.poppins(fontSize: 16, color: Colors.black, height: 1.5),
        children: spans,
      ),
    );
  }
}

void openInAppBrowser(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.e, // Opens in in-app browser
    );
  } else {
    throw 'Could not launch $url';
  }
}
