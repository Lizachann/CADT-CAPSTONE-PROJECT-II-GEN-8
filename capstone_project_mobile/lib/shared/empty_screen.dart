import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String text;
  const EmptyScreen({super.key, this.text = 'Empty data'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
