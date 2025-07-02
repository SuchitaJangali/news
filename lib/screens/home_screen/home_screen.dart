import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/screens/home_screen/list_news/new_list_screens.dart';
import 'package:news/screens/home_screen/list_news/new_list_view_model.dart';
import 'package:news/uitils/base_app_notifer.dart';
import 'package:provider/provider.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      context.read<NewsProvider>().fetchNews();
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy')
                              .format(DateTime.now())
                              .toString() ??
                          '11 July, 2020',
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                Text(
                  'Hey, James!',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                Text(
                  'Discover Latest News',
                  style: GoogleFonts.poppins(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Consumer<NewsProvider>(builder: (context, view, child) {
                  print("Object ${view.selectedCategory}");
                  return // Search Bar
                      Column(children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search For News',
                                border: InputBorder.none,
                              ),
                              controller: searchController,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          child: IconButton(
                            icon: const Icon(
                              Icons.search,
                            ),
                            onPressed: () {
                              if (searchController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please Enter Something!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              FocusScope.of(context).unfocus();
                              view.fetchNews(
                                query: searchController.text,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Categories
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CategoryIcon(
                            title: 'Politics',
                            icon: Icons.mic,
                            onTap: (String query) {
                              print("q: $query");
                              view.selectedCategory = query;
                              context
                                  .read<NewsProvider>()
                                  .fetchNews(query: query);
                              searchController.clear();
                            },
                          ),
                          CategoryIcon(
                            title: 'Movies',
                            icon: Icons.movie,
                            onTap: (String query) {
                              print("q: $query");
                              view.selectedCategory = query;
                              context
                                  .read<NewsProvider>()
                                  .fetchNews(query: query);
                              searchController.clear();
                            },
                          ),
                          CategoryIcon(
                            title: 'Sports',
                            icon: Icons.sports,
                            onTap: (String query) {
                              print("q: $query");
                              view.selectedCategory = query;
                              context
                                  .read<NewsProvider>()
                                  .fetchNews(query: query);
                              searchController.clear();
                            },
                          ),
                          CategoryIcon(
                            title: 'Crime',
                            icon: Icons.gavel,
                            onTap: (String query) {
                              print("q: $query");
                              view.selectedCategory = query;
                              context
                                  .read<NewsProvider>()
                                  .fetchNews(query: query);
                              searchController.clear();
                            },
                          ),
                        ]),
                  ]);
                }),
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
                  if (newsProvider.articles.isEmpty) {
                    return Center(
                      child: Text(
                          "No News in Category ${newsProvider.selectedCategory}"),
                    );
                  }

                  return ListView.builder(
                      itemCount: newsProvider.articles.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 16),
                      scrollDirection: Axis.vertical,
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
    bool isSelected = context.read<NewsProvider>().selectedCategory == title;
    print("$title is Selected $isSelected");
    return InkWell(
      onTap: () {
        onTap(title);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor:
                isSelected ? Colors.red[100] : Colors.grey.withOpacity(0.5),
            child: Icon(icon, color: isSelected ? Colors.red : Colors.black),
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
