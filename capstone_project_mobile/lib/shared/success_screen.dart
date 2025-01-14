import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.successMsg,
      required this.backBtn,
      required this.nextBtn,
      required this.backBtnTitle,
      required this.nextBtnTitle});

  final String successMsg;
  final String backBtnTitle;
  final String nextBtnTitle;
  final void Function() backBtn;
  final void Function() nextBtn;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 3,
      shadowColor: Colors.grey[500],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(128)),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 300, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: const Icon(
                  Icons.check,
                  size: 100,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                successMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  overflow: TextOverflow.visible,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: backBtn,
                      style: textButtonStyle,
                      child: Text(backBtnTitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: nextBtn,
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        elevation: 3,
                        shadowColor: Colors.grey[500],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(128)),
                        ),
                      ),
                      child: Text(nextBtnTitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
