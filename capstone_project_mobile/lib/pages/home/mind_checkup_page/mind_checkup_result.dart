import 'package:capstone_project_mobile/core/model/mind_checkup.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/home/find_activity_page/find_activity_page.dart';
import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:flutter/material.dart';

class MindCheckupResultPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final List<String> selectedAnswers;
  final Map<String, String> selectedAnswers;
  final CreateMindCheckup createMindCheckup;

  MindCheckupResultPage({
    super.key,
    required this.selectedAnswers,
    required this.createMindCheckup,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surface,
      appBar: const MyAppBar(
        title: "Mind Checkup Result",
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Mood Monitor',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            _buildResultCard(context),
            const SizedBox(
              height: 40,
            ),
            _buildButton(context, 'View Recommendation Activity', '1'),
            const SizedBox(
              height: 15,
            ),
            _buildButton(context, 'Book A Therapy session?', '2'),
            const SizedBox(
              height: 15,
            ),
            _buildButton(context, 'View Resource', '3'),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Disclaimer',
              style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "The scores on the following self-assessment do not reflect any particular diagnosis or course of treatment. ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  overflow: TextOverflow.visible,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "They are meant as a tool to help assess your level of stress. If you have any further concerns about your current well being, you may contact EAP and talk confidentially to one of our specialists.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  overflow: TextOverflow.visible,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            //get answer
            // SizedBox(
            //   height: 200,
            //   child: ListView.builder(
            //     itemCount: selectedAnswers.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text('Question ${index + 1}'),
            //         subtitle:
            //             Text(selectedAnswers[index] ?? 'No answer selected'),
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String index) {
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
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            if (index == '1') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FindActivityPage(),
                ),
              );
            } else if (index == '2') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutPage(selectedIndex: 2),
                ),
              );
            } else if (index == '3') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutPage(selectedIndex: 3),
                ),
              );
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.visible,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(226, 239, 255, 1),
        shadowColor: Colors.grey,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 59,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.12),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
          color: Color.fromRGBO(226, 239, 255, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Scale   :',
                              style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.visible,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              createMindCheckup.result,
                              style: TextStyle(
                                color: colorScheme.primary,
                                overflow: TextOverflow.visible,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class MindCheckupResultPage extends StatelessWidget {
//   final Map<String, String> selectedAnswers;

//   const MindCheckupResultPage({Key? key, required this.selectedAnswers}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mind Checkup Results'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Thank you for completing the mind checkup. Here are your results:',
//               style: Theme.of(context).textTheme.headline6,
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: selectedAnswers.entries.map((entry) {
//                   return ListTile(
//                     title: Text(entry.key),
//                     subtitle: Text(entry.value),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
