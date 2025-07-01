import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/screens/list_news/new_list_screens.dart';
import 'package:news/screens/list_news/new_list_view_model.dart';
import 'package:news/uitils/base_app_notifer.dart';
import 'package:provider/provider.dart';

class NewsHomePage extends StatelessWidget {
  const NewsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NEWS',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '11 July, 2020',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Hey, James!',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                Text(
                  'Discover Latest News',
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search For News',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryIcon(
                      title: 'Politics',
                      icon: Icons.mic,
                      onTap: (String query) {
                        print("q: $query");
                        context.read<NewsProvider>().fetchNews(query: query);
                      },
                    ),
                    CategoryIcon(
                      title: 'Movies',
                      icon: Icons.movie,
                      onTap: (String query) {
                        print("q: $query");
                        context.read<NewsProvider>().fetchNews(query: query);
                      },
                    ),
                    CategoryIcon(
                      title: 'Sports',
                      icon: Icons.sports,
                      onTap: (String query) {
                        print("q: $query");
                        context.read<NewsProvider>().fetchNews(query: query);
                      },
                    ),
                    CategoryIcon(
                      title: 'Crime',
                      icon: Icons.gavel,
                      onTap: (String query) {
                        print("q: $query");
                        context.read<NewsProvider>().fetchNews(query: query);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Consumer<NewsProvider>(builder: (context, newsProvider, child) {
                  if (newsProvider.state == NotifierState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (newsProvider.state == NotifierState.error) {
                    return Center(
                      child: Text(newsProvider.errorMessage ?? "Error"),
                    );
                  }

                  return ListView.builder(
                      itemCount: newsProvider.articles.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Article(
                          article: newsProvider.articles[index],
                        );
                      });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function(String query) onTap;

  const CategoryIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.red[100],
            child: Icon(icon, color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String time;

  const NewsItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
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
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
