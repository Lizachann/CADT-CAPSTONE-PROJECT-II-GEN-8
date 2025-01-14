import 'package:capstone_project_mobile/components/slideshow/slide_show_page.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/home/find_activity_page/details_activity.dart';
import 'package:capstone_project_mobile/pages/home/find_activity_page/find_category_activity.dart';
import 'package:flutter/material.dart';

final List<DetailItem> detailActivitys = [
  DetailItem(
    type: 'sport',
    logo: 'lib/assets/images/activitys/basketball_logo.png',
    title: 'Basketball',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/basketball.png',
      title: 'Basketball',
      description:
          "Basketball is a team sport where two teams, usually consisting of five players each, compete to score points by shooting a ball through the opponent's hoop. The game is played on a rectangular court with a hoop at each end. Players move the ball by dribbling or passing, aiming to score more points than the opposing team.",
      fitness:
          "Basketball enhances cardiovascular health, builds muscle strength, and improves coordination and balance.",
      mentalhealth:
          "Playing basketball can reduce stress, boost mood, and improve mental well-being through the release of endorphins.",
      socialskill:
          "The sport fosters teamwork, communication, and cooperation, helping players develop strong social bonds. Discipline and Time Management: Regular practice and game schedules instill discipline, time management, and goal-setting skills.",
      development:
          "Basketball requires strategic thinking, quick decision-making, and enhances cognitive functions like concentration and spatial awareness.",
      stresslvl: "From 4-5 lvl",
    ),
  ),
  DetailItem(
    type: 'sport',
    logo: 'lib/assets/images/activitys/table_tennis_logo.png',
    title: 'Table Tennis',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/table_tennis.png',
      title: 'Table Tennis',
      description:
          "Table Tennis, also known as Ping Pong, is a fast-paced sport played on a rectangular table divided by a net. Two or four players use small paddles to hit a lightweight ball back and forth. The objective is to score points by making the ball land on the opponent’s side of the table without being returned. Players must serve the ball diagonally and alternate serves every two points. The game emphasizes quick reflexes, precision, and strategic shot placement.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),
  DetailItem(
    type: 'sport',
    logo: 'lib/assets/images/activitys/badminton_logo.png',
    title: 'Badminton',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/badminton.png',
      title: 'Badminton',
      description:
          "Badminton is a racquet sport played on a rectangular court divided by a net. Players hit a shuttlecock back and forth, aiming to land it in the opponent's court to score points. Games are typically played to 21 points, and can be in singles or doubles format. The sport requires agility, precision, and quick reflexes, and is enjoyed both recreationally and competitively worldwide.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),
  DetailItem(
    type: 'sport',
    logo: 'lib/assets/images/activitys/sport.png',
    title: 'Swimming',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/swimming.png',
      title: 'Swimming',
      description:
          "Swimming is a water-based sport and activity involving the movement of the body through water using various strokes such as freestyle, backstroke, breaststroke, and butterfly. It can be practiced for recreation, fitness, or competition. Competitive swimming features races over various distances in pools or open water, with athletes aiming for the fastest times. Swimming is valued for its full-body workout benefits, enhancing cardiovascular health, strength, and endurance. It is also a crucial life skill for safety in and around water.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),
  DetailItem(
    type: 'selfcare',
    logo: 'lib/assets/images/activitys/selfcare.png',
    title: 'Meditation',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/meditation.png',
      title: 'Meditation',
      description:
          "A practice of focusing the mind and achieving a state of mental clarity and emotional calm, often through techniques like deep breathing and mindfulness.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),
  DetailItem(
    type: 'selfcare',
    logo: 'lib/assets/images/activitys/selfcare.png',
    title: 'Reading',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/reading.png',
      title: 'Reading',
      description:
          "The activity of interpreting and engaging with written text, whether for education, entertainment, or personal growth.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),

  DetailItem(
    type: 'selfcare',
    logo: 'lib/assets/images/activitys/selfcare.png',
    title: 'Journaling',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/journaling.png',
      title: 'Journaling',
      description:
          "The process of writing down thoughts, experiences, and reflections in a journal to explore emotions and document personal growth.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),

  DetailItem(
    type: 'skill',
    logo: 'lib/assets/images/activitys/skill.png',
    title: 'Cooking',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/cooking.png',
      title: 'Cooking',
      description:
          "The art of preparing and combining ingredients to create meals, involving techniques such as chopping, sautéing, baking, and grilling.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),

  DetailItem(
    type: 'skill',
    logo: 'lib/assets/images/activitys/skill.png',
    title: 'Photography',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/photography.png',
      title: 'Photography',
      description:
          "The art and practice of capturing images using a camera, focusing on composition, lighting, and subject matter to create visually appealing photos.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),

  DetailItem(
    type: 'skill',
    logo: 'lib/assets/images/activitys/skill.png',
    title: 'Crocheting',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/crocheting.png',
      title: 'Crocheting',
      description:
          "A craft where yarn is looped together using a crochet hook to create items like blankets, scarves, and clothing.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),
  DetailItem(
    type: 'skill',
    logo: 'lib/assets/images/activitys/skill.png',
    title: 'Play a Guitar',
    navigation: (context) => DetailsActivityPage(
      img: 'lib/assets/images/activitys/guitar.png',
      title: 'Play a Guitar',
      description:
          "The skill of producing music by strumming or plucking the strings of a guitar, involving techniques such as chord progressions and fingerpicking.",
      fitness: "",
      mentalhealth: "",
      socialskill: "",
      development: "",
      stresslvl: "",
    ),
  ),

  // DetailItem(
  //   type: 'skill',
  //   logo: 'lib/assets/images/activitys/sport.png',
  //   title: 'Basketball',
  //   navigation: (context) => DetailsActivityPage(
  //     img: 'lib/assets/images/activitys/basketball.png',
  //     title: 'Basketball',
  //     description: "",
  //    fitness: "",
  //     mentalhealth: "",
  //     socialskill: "",
  //     development: "",
  //     stresslvl: "",
  //   ),
  // ),
];

class FindActivityPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<GridViewItem> items = [
    GridViewItem(
      color: const Color.fromRGBO(255, 250, 222, 1),
      text: 'Sports',
      img: 'lib/assets/images/activitys/sport.png',
      navigation: (context) => CategoryActivity(
        type: 'sport',
        actionFilter: true,
        detailActivitys: detailActivitys,
      ),
    ),
    GridViewItem(
      color: const Color.fromRGBO(255, 236, 234, 1),
      text: 'Self Care',
      img: 'lib/assets/images/activitys/selfcare.png',
      navigation: (context) => CategoryActivity(
        type: 'selfcare',
        actionFilter: true,
        detailActivitys: detailActivitys,
      ),
    ),
    GridViewItem(
      color: const Color.fromRGBO(211, 245, 229, 1),
      text: 'Skills',
      img: 'lib/assets/images/activitys/skill.png',
      navigation: (context) => CategoryActivity(
        type: 'skill',
        actionFilter: true,
        detailActivitys: detailActivitys,
      ),
    ),
  ];

  final List<SlideShowItem> slideImgNavs = [
    SlideShowItem(
      img: 'lib/assets/images/activitys/basketball.png',
      navigation: (context) => DetailsActivityPage(
        img: 'lib/assets/images/activitys/basketball.png',
        title: 'Basketball',
        description:
            "Basketball is a team sport where two teams, usually consisting of five players each, compete to score points by shooting a ball through the opponent's hoop. The game is played on a rectangular court with a hoop at each end. Players move the ball by dribbling or passing, aiming to score more points than the opposing team.",
        fitness:
            "Basketball enhances cardiovascular health, builds muscle strength, and improves coordination and balance.",
        mentalhealth:
            "Playing basketball can reduce stress, boost mood, and improve mental well-being through the release of endorphins.",
        socialskill:
            "The sport fosters teamwork, communication, and cooperation, helping players develop strong social bonds. Discipline and Time Management: Regular practice and game schedules instill discipline, time management, and goal-setting skills.",
        development:
            "Basketball requires strategic thinking, quick decision-making, and enhances cognitive functions like concentration and spatial awareness.",
        stresslvl: "From 4-5 lvl",
      ),
    ),
    SlideShowItem(
      img: 'lib/assets/images/activitys/journaling.png',
      navigation: (context) => DetailsActivityPage(
        img: 'lib/assets/images/activitys/journaling.png',
        title: 'Journaling',
        description:
            "The process of writing down thoughts, experiences, and reflections in a journal to explore emotions and document personal growth.",
        fitness: "",
        mentalhealth: "",
        socialskill: "",
        development: "",
        stresslvl: "",
      ),
    ),
    SlideShowItem(
      img: 'lib/assets/images/activitys/guitar.png',
      navigation: (context) => DetailsActivityPage(
        img: 'lib/assets/images/activitys/guitar.png',
        title: 'Play a Guitar',
        description:
            "The skill of producing music by strumming or plucking the strings of a guitar, involving techniques such as chord progressions and fingerpicking.",
        fitness: "",
        mentalhealth: "",
        socialskill: "",
        development: "",
        stresslvl: "",
      ),
    ),
  ];

  FindActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorScheme.surface,
        appBar: const MyAppBar(
          title: "Find Your Activity",
          actionsSearchEnabled: true,
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
            Text(
              'Popular Activities List',
              style: textTheme.displayLarge?.copyWith(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            _buildActivityList(context),
            const SizedBox(height: 20),
            Text(
              'Base on your stress level :',
              style: textTheme.displayLarge?.copyWith(
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            SlideshowPage(
              slideImgNav: slideImgNavs,
            ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              text: 'View All Lists',
            ),
            const SizedBox(height: 20),
            _buildButton(
              context,
              text: 'View Save Activites',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, {required String text}) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.secondary, colorScheme.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (text == 'View All Lists') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryActivity(
                    detailActivitys: detailActivitys,
                  ),
                ),
              );
            } else if (text == 'View Save Activites') {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ViewListsPage()),
              // );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: colorScheme.onPrimary,
            textStyle: const TextStyle(fontSize: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityList(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => item.navigation(context)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: item.color,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20),
                              child: Image.asset(
                                item.img,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text(
                                item.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }).toList(),
        ),
      ),
    );
  }
}

class GridViewItem {
  final Color color;
  final String text;
  final String img;
  final Function(BuildContext) navigation;
  GridViewItem(
      {required this.color,
      required this.text,
      required this.img,
      required this.navigation});
}

class DetailItem {
  final String logo;
  final String title;
  final String type;
  final Function(BuildContext) navigation;

  DetailItem(
      {required this.type,
      required this.title,
      required this.logo,
      required this.navigation});
}
