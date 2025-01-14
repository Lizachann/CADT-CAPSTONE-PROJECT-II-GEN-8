import 'package:capstone_project_mobile/components/buttons/expandable_tile.dart';
import 'package:capstone_project_mobile/components/buttons/favorite_button.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:flutter/material.dart';

class DetailsActivityPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String img;
  final String title;
  final String description;
  final String fitness;
  final String mentalhealth;
  final String socialskill;
  final String development;
  final String stresslvl;

  DetailsActivityPage({
    super.key,
    required this.img,
    required this.title,
    required this.description,
    required this.fitness,
    required this.mentalhealth,
    required this.socialskill,
    required this.development,
    required this.stresslvl,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorScheme.surface,
        appBar: const MyAppBar(
          title: "Details Activity",
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              img,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    title,
                    style: textTheme.displayLarge?.copyWith(
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: FavoriteButton(),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'What is $title ?',
              style: textTheme.displayMedium?.copyWith(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: textTheme.displayMedium?.copyWith(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Benefit of $title',
              style: textTheme.displayMedium?.copyWith(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildDetails(context, 'Fitness', fitness),
            const SizedBox(
              height: 20,
            ),
            _buildDetails(context, 'Mental Health', mentalhealth),
            const SizedBox(
              height: 20,
            ),
            _buildDetails(context, 'Social Skill', socialskill),
            const SizedBox(
              height: 20,
            ),
            _buildDetails(context, 'Development', development),
            const SizedBox(
              height: 20,
            ),
            _buildDetails(context, 'Stress Level', stresslvl),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, String maintext, String subtext) {
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
          child: ExpandableTile(
            title: maintext,
            text1: subtext,
          ),
        ),
      ),
    );
  }
}
