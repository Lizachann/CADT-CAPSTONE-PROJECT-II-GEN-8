import 'package:capstone_project_mobile/components/cards/post_card.dart';
import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/components/lists/comments_list.dart';
import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/controller/patient_comment_controller.dart';
import 'package:capstone_project_mobile/core/controller/post_controller.dart';
import 'package:capstone_project_mobile/core/model/dto/create_comment_dto.dart';
import 'package:capstone_project_mobile/core/model/error_response.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:capstone_project_mobile/shared/error_screen.dart';
import 'package:capstone_project_mobile/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final PostController postController = Get.put(PostController());
  final PatientCommentController patientCommentController =
      Get.put(PatientCommentController());

  @override
  Widget build(BuildContext context) {
    postController.handleGetOnePost(widget.postId);
    patientCommentController.handleGetAllParentComments(postId: widget.postId);
    final AuthController authController = Get.put(AuthController());
    final user = authController.user;

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Detailed Post',
      ),
      body: Obx(() {
        return _buildBody();
      }),
      bottomNavigationBar: _buildCommentButton(context,
          textEditingController: textEditingController,
          onSubmitted: (text) async {
        if (user.value == null) {
          return Get.to(() => const LoginEmail());
        } else {
          await patientCommentController
              .handleCreateComment(
            createCommentDto: CreateCommentDto(
              content: text,
              patient: user.value!.id,
              post: widget.postId,
            ),
          )
              .then((value) async {
            await postController.handleGetOnePost(widget.postId);
            textEditingController.clear();
          }).catchError((err) {
            ErrorResponse errorResponse = ErrorResponse.fromJson(err);
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                text: errorResponse.validationMessages.toString(),
              ),
            );
          });
        }
      }),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: postController.getOnePost.value,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var post = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              await postController.handleGetOnePost(widget.postId);
              await patientCommentController.handleGetAllParentComments(
                  postId: widget.postId);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PostCard(
                    post: post,
                    isCurrentPost: post.id == widget.postId,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CommentsList(
                    postId: widget.postId,
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: ErrorScreen(
              onTryAgain: () async {
                await postController.handleGetOnePost(widget.postId);
              },
              errorObject: snapshot.error,
            ),
          );
        }

        return const LoadingScreen();
      },
    );
  }

  Widget _buildCommentButton(
    BuildContext context, {
    required TextEditingController textEditingController,
    required void Function(String)? onSubmitted,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9999.0),
            borderSide: BorderSide(color: colorScheme.secondary),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              LucideIcons.messageCircle,
              color: colorScheme.tertiary,
            ),
            onPressed: () {
              if (onSubmitted != null) onSubmitted(textEditingController.text);
            },
          ),
          hintText: 'Write a comment',
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
