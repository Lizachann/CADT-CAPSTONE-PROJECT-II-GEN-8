import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: "Comment"),
      body: Center(
        child: Text('Comment page'),
      ),
    );
  }
}
  