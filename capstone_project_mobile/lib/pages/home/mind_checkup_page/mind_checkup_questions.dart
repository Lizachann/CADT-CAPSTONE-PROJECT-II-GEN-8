// import 'dart:convert';
import 'package:capstone_project_mobile/core/model/mind_checkup.dart';
import 'package:capstone_project_mobile/core/services/post_service.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:capstone_project_mobile/components/buttons/mind_checkup_answer_button.dart';
import 'package:capstone_project_mobile/core/model/mind_checkup_question.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/home/mind_checkup_page/mind_checkup_result.dart';
import 'package:capstone_project_mobile/pages/home/mind_checkup_page/start_mind_checkup.dart';
import 'package:get/get.dart';

class MindCheckupQuestionsPage extends StatefulWidget {
  const MindCheckupQuestionsPage({super.key});

  @override
  State<MindCheckupQuestionsPage> createState() =>
      _MindCheckupQuestionsPageState();
}

class _MindCheckupQuestionsPageState extends State<MindCheckupQuestionsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentQuestionIndex = 0;
  final List<int?> _selectedAnswers =
      List.generate(mindchekquestions.length, (index) => null);
  String? _errorMessage;

  // Future<void> _postAnswers(Map<String, String> answers) async {
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(answers),
  //   );

  //   if (response.statusCode == 200) {
  //     // Handle successful response
  //     print('Data posted successfully');
  //   } else {
  //     // Handle error response
  //     print('Failed to post data: ${response.statusCode}');
  //   }
  // }

  void _goToNextQuestion() async {
    if (_selectedAnswers[_currentQuestionIndex] == null) {
      setState(() {
        _errorMessage = 'Please select an answer.';
      });
      return;
    }
    if (_currentQuestionIndex < mindchekquestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _errorMessage = null;
      });
    } else {
      final answersMap = _getAllSelectedAnswers();
      // ignore: avoid_print
      var createMindCheckup =
          await PostService.mindCheckUp(answersMap).then((value) {
        CreateMindCheckup res = CreateMindCheckup.fromJson(value);
        return res;
      });
      Get.to(() => MindCheckupResultPage(
          selectedAnswers: answersMap, createMindCheckup: createMindCheckup));
    }
  }

  void _goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _errorMessage = null;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StartMindCheckupPage()),
      );
      _errorMessage = null;
    }
  }

  Map<String, String> _getAllSelectedAnswers() {
    final selectedAnswersMap = <String, String>{};

    for (int i = 0; i < mindchekquestions.length; i++) {
      final question = mindchekquestions[i];
      final selectedIndex = _selectedAnswers[i];

      if (selectedIndex != null &&
          selectedIndex >= 0 &&
          selectedIndex < question.answers.length) {
        selectedAnswersMap[question.key] = question.answers[selectedIndex];
      }
    }

    return selectedAnswersMap;
  }

  void _updateAnswer(int index) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = index;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final question = mindchekquestions[_currentQuestionIndex];
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surface,
      appBar: const MyAppBar(
        title: "Mind Checkup",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      question.number,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Text(
                    question.text,
                    style: const TextStyle(
                      overflow: TextOverflow.visible,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            MindCheckupAnswerChoices(
              selectedAnswer: _selectedAnswers[_currentQuestionIndex],
              onAnswerSelected: _updateAnswer,
              answers: question.answers,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 120,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: colorScheme.surface,
        elevation: 0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 60,
                child: ElevatedButton(
                  onPressed: _goToPreviousQuestion,
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Return',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 60,
                child: ElevatedButton(
                  onPressed: _goToNextQuestion,
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 24,
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
