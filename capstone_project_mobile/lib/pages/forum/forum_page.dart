import 'package:capstone_project_mobile/components/buttons/floating_post_button.dart';
import 'package:capstone_project_mobile/components/cards/post_card.dart';
import 'package:capstone_project_mobile/shared/empty_screen.dart';
import 'package:capstone_project_mobile/shared/error_screen.dart';
import 'package:capstone_project_mobile/core/controller/post_controller.dart';
import 'package:capstone_project_mobile/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    postController.handleGetAllPosts();

    return Scaffold(
      floatingActionButton: const FloatingPostButton(),
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: postController.handleGetAllPosts,
          child: FutureBuilder(
            future: postController.getAllPosts.value,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var posts = snapshot.data!;
                if (posts.isEmpty) {
                  return const EmptyScreen(
                    text: 'No posts',
                  );
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (ctx, index) {
                    return PostCard(
                      post: posts[index],
                      isCurrentPost: false,
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ErrorScreen(
                    onTryAgain: () async {
                      await postController.handleGetAllPosts();
                    },
                    errorObject: snapshot.error,
                  ),
                );
              }
              return const LoadingScreen();
            },
          ),
        );
      }),
    );
  }
}
