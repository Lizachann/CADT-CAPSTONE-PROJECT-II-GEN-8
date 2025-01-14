import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/home/mind_checkup_page/mind_checkup_questions.dart';
import 'package:flutter/material.dart';

class StartMindCheckupPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  StartMindCheckupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorScheme.surface,
        appBar: const MyAppBar(
          title: "Mind Checkup",
        ),
        body: _buildBody(context));
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
              'What is Mind Checkup?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "The Perceived Stress Scale (PSS) is a classic stress assessment instrument. The tool, while originally developed in 1983, remains a popular choice for helping us understand how different situations affect our feelings and our perceived stress.",
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
              "The questions in this scale ask about your feelings and thoughts during the last month. In each case, you will be asked to indicate how often you felt or thought a certain way.",
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
              "There are 10 questions that you will be answering, and the best approach is to answer fairly quickly.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  overflow: TextOverflow.visible,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MindCheckupQuestionsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  textStyle: const TextStyle(fontSize: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
                child: const Text(
                  'Begin Test',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
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
                  color: Colors.grey,
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
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
