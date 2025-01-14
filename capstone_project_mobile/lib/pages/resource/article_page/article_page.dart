import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/components/buttons/expandable_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:capstone_project_mobile/components/buttons/favorite_button.dart';

class ArticlePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> articles = [
    {
      'img': 'lib/assets/images/article.png',
      'title': 'Coping with ADHD',
      'author': 'by Louis Armstrong',
      'date': '2019',
      'url': 'https://example.com/article1'
    },
    {
      'img': 'lib/assets/images/article.png',
      'title': 'Mental Health',
      'author': 'by Louis Godman',
      'date': '2012',
      'url': 'https://example.com/article2'
    },
    {
      'img': 'lib/assets/images/article.png',
      'title': 'Balance Living',
      'author': 'by Louis Godman',
      'date': '2012',
      'url': 'https://youtu.be/tRFLs_-54gE?si=BCraxyvBYz9ANlHI'
    },
    {
      'img': 'lib/assets/images/article.png',
      'title': 'Tips from Professional',
      'author': 'by Louis Godman',
      'date': '2012',
      'url': 'https://www.youtube.com/'
    },
  ];

  ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surface,
      appBar: const MyAppBar(
        title: "Article and Research",
        actionsSearchEnabled: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(context),
            const SizedBox(height: 20),
            ...articles.map((article) {
              return Column(
                children: [
                  _buildArticleCard(
                    context,
                    article['img']!,
                    article['title']!,
                    article['author']!,
                    article['date']!,
                    article['url']!,
                  ),
                  const SizedBox(height: 25),
                ],
              );
            }),
            const SizedBox(height: 20),
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
            title: 'Empower Your Mind with Knowledge',
            text1:
                'Dive into our handpicked selection of insightful articles and research papers on mental health and self-help.',
            text2:
                "Stay informed with the latest findings, expert advice, and transformative strategies to enhance your well-being.",
            text3:
                'Unlock the power of knowledge and take control of your mental health journey today.',
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    final img,
    final title,
    final author,
    final date,
    final url,
  ) {
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
        height: 150,
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
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
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
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
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
