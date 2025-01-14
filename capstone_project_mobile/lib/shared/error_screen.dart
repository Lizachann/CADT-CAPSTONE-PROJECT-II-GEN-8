import 'dart:convert';
import 'package:capstone_project_mobile/core/model/error_response.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ErrorScreen extends StatelessWidget {
  final void Function()? onTryAgain;
  final Object? errorObject;
  const ErrorScreen({
    super.key,
    required this.onTryAgain,
    required this.errorObject,
  });

  @override
  Widget build(BuildContext context) {
    ErrorResponse errorResponse =
        ErrorResponse.fromJson(jsonDecode(jsonEncode(errorObject)));

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Something went wrong",
            style: textTheme.displayLarge!.copyWith(
              color: colorScheme.primary,
              overflow: TextOverflow.visible,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            errorResponse.statusCode.toString(),
            style: textTheme.displayMedium!.copyWith(
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: List.generate(
              errorResponse.messages!.length,
              (index) => Text(
                errorResponse.messages![index],
                style: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          Column(
            children: List.generate(
              errorResponse.validationMessages!.length,
              (index) => Text(
                errorResponse.validationMessages![index],
                style: const TextStyle(
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colorScheme.primary),
                foregroundColor:
                    MaterialStatePropertyAll(colorScheme.background),
              ),
              onPressed: onTryAgain,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.iterationCw),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Try again'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
