import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/components/buttons/expandable_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:capstone_project_mobile/components/buttons/favorite_button.dart';

import 'package:flutter/material.dart';

class BookRecommendationPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> books = [
    {
      'img': 'lib/assets/images/books/book1.png',
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'date': '2017',
      'url': 'https://www.youtube.com/'
    },
    {
      'img': 'lib/assets/images/books/book2.png',
      'title': 'The Subtle Art of Not Giving a F*ck',
      'author': 'Mark Manson',
      'date': '2017',
      'url': 'https://www.youtube.com/'
    },
    {
      'img': 'lib/assets/images/books/book3.png',
      'title': 'Permission to come home',
      'author': 'Mark Manson',
      'date': '2017',
      'url': 'https://www.youtube.com/'
    },
  ];

  BookRecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorScheme.surface,
        appBar: const MyAppBar(
          title: "Book Recommedation",
          actionsSearchEnabled: true,
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(context),
            const SizedBox(
              height: 20,
            ),
            ...books.map((book) {
              return Column(
                children: [
                  _buildBookCard(context, book['img']!, book['title']!,
                      book['author']!, book['date']!, book['url']!),
                  const SizedBox(height: 25),
                ],
              );
            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: colorScheme.onPrimary,
            textStyle: const TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
          ),
          child: const ExpandableTile(
            title: 'Discover Your Path to Wellness',
            text1:
                'Explore our curated collection of top mental health and self-help books.',
            text2:
                "Whether you're looking for inspiration, practical advice, or a deeper understanding of your emotions, our app connects you with the best reads to nurture your mind and soul.",
            text3: 'Start your journey to a better you, one book at a time.',
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, final img, final title,
      final author, final date, final url) {
    return ElevatedButton(
      onPressed: () => _launchURL(url),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.12),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, 5),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Image.asset(
                  img,
                  fit: BoxFit.fitHeight,
                  // width: 150,
                  // height: 150,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.visible,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            author,
                            style: const TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.visible,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.black,
                              overflow: TextOverflow.visible,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: FavoriteButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
