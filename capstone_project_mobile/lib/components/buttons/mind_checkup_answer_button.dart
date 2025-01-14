import 'package:flutter/material.dart';

class MindCheckupAnswerButton extends StatelessWidget {
  final String number;
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const MindCheckupAnswerButton({
    super.key,
    required this.number,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(181, 213, 255, 0.93),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              Icon(
                isSelected ? Icons.circle : Icons.circle_outlined,
                color: isSelected ? colorScheme.primary : Colors.black,
                size: 24,
              ),
              const SizedBox(width: 20),
              Text(
                number,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Text(
                  text,
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
        ),
      ),
    );
  }
}

class MindCheckupAnswerChoices extends StatelessWidget {
  final int? selectedAnswer;
  final void Function(int) onAnswerSelected;
  final List<String> answers;

  const MindCheckupAnswerChoices({
    super.key,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(answers.length, (index) {
        final answerText = answers[index];

        return MindCheckupAnswerButton(
          number: (index + 1).toString(),
          text: answerText,
          isSelected: selectedAnswer == index,
          onPressed: () => onAnswerSelected(index),
        );
      }),
    );
  }
}
