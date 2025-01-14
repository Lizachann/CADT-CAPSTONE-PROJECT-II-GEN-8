import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/core/model/dto/create_total_score.dart';
import 'package:capstone_project_mobile/core/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project_mobile/components/buttons/stress_answer_button.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/home/stress_monitor_page/start_stress_monitor.dart';
import 'package:capstone_project_mobile/pages/home/stress_monitor_page/stress_monitor_result.dart';
import 'package:capstone_project_mobile/core/model/stress_monitor_question.dart';

class MonitorQuestionsPage extends StatefulWidget {
  const MonitorQuestionsPage({super.key});

  @override
  State<MonitorQuestionsPage> createState() => _MonitorQuestionsPageState();
}

class _MonitorQuestionsPageState extends State<MonitorQuestionsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentQuestionIndex = 0;
  final List<int?> _selectedAnswers =
      List.generate(stressquestions.length, (index) => null);
  String? _errorMessage;

  bool loading = false;

  void _goToNextQuestion() async {
    final totalScore = _calculateTotalScore();

    if (_selectedAnswers[_currentQuestionIndex] == null) {
      setState(() {
        _errorMessage = 'Please select an answer.';
      });
      return;
    }

    if (_currentQuestionIndex < stressquestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = null;
        loading = true;
      });

      try {
        await PostService.sendTotalScore(SaveTotalScore(
          totalScore: totalScore,
          patient: '63686861790123456789abcd',
        ));
        // Navigate only if the widget is still mounted
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MonitorResultPage(totalScore: totalScore),
            ),
          );
        }
      } catch (err) {
        // Show error dialog only if the widget is still mounted
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(text: err.toString()),
          );
        }
      } finally {
        // Always reset the loading state
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }
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
        MaterialPageRoute(builder: (context) => StartMonitorPage()),
      );
      _errorMessage = null;
    }
  }

  void _updateAnswer(int index) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = index;
      _errorMessage = null;
    });
  }

  int _calculateTotalScore() {
    int totalScore = 0;

    for (int i = 0; i < stressquestions.length; i++) {
      final answerIndex = _selectedAnswers[i];
      if (answerIndex != null) {
        if (i == 3 || i == 4 || i == 6 || i == 7) {
          totalScore += (4 - answerIndex); // Reversed scoring
        } else {
          totalScore += answerIndex; // Normal score
        }
      }
    }

    return totalScore;
  }

  // int _calculateTotalScore() {
  //   int totalScore = 0;

  //   for (int i = 0; i < stressquestions.length; i++) {
  //     final answerIndex = _selectedAnswers[i];
  //     if (answerIndex != null) {
  //       if (i == 4 || i == 5 || i == 7 || i == 8) {
  //         // Ensure that answerIndex is within the expected range
  //         if (answerIndex >= 0 && answerIndex <= 4) {
  //           totalScore += (4 - answerIndex); // Apply reversed scoring
  //         } else {
  //           // Handle unexpected answerIndex values
  //           print("Unexpected answerIndex: $answerIndex at question index $i");
  //         }
  //       } else {
  //         // Normal scoring
  //         if (answerIndex >= 0 && answerIndex <= 4) {
  //           totalScore += answerIndex; // Apply normal scoring
  //         } else {
  //           // Handle unexpected answerIndex values
  //           print("Unexpected answerIndex: $answerIndex at question index $i");
  //         }
  //       }
  //     }
  //   }

  //   return totalScore;
  // }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final question = stressquestions[_currentQuestionIndex];
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surface,
      appBar: const MyAppBar(
        title: "Stress Monitor",
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
            StressAnswerChoices(
              selectedAnswer: _selectedAnswers[_currentQuestionIndex],
              onAnswerSelected: _updateAnswer,
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
