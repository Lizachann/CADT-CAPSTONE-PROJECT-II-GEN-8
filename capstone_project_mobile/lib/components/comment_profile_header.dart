import 'package:capstone_project_mobile/components/cards/profile_picture_card.dart';
import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/controller/patient_comment_controller.dart';
import 'package:capstone_project_mobile/core/controller/post_controller.dart';
import 'package:capstone_project_mobile/core/model/patient_comment_model.dart';
import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentProfileHeader extends StatefulWidget {
  final ParentCommentV2 comment;
  const CommentProfileHeader({
    super.key,
    required this.comment,
  });

  @override
  State<CommentProfileHeader> createState() => _CommentProfileHeaderState();
}

class _CommentProfileHeaderState extends State<CommentProfileHeader> {
  PatientCommentController patientCommentController =
      Get.put(PatientCommentController());
  PostController postController = Get.put(PostController());

  final GlobalKey _iconButtonKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side
        Row(
          children: [
            ProfilePictureCard(
              imgPath: widget.comment.patient.profileImg,
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.comment.patient.username),
                Text(
                  DateFormat.MMMd().add_jm().format(
                      DateTime.parse(widget.comment.createdAt).toLocal()),
                ),
              ],
            )
          ],
        ),

        // Right side
        IconButton(
          key: _iconButtonKey,
          onPressed: () {
            _showDropdownMenu(context);
          },
          icon: const Icon(Icons.more_vert),
        )
      ],
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final user = authController.user;
    final RenderBox renderBox =
        _iconButtonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, // Left
        offset.dy + renderBox.size.height, // Top (below the icon button)
        0,
        MediaQuery.of(context).size.height -
            offset.dy -
            renderBox.size.height, // Bottom
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () async {
              if (user.value == null) {
                return Get.to(() => const LoginEmail());
              }
              if (user.value!.id == widget.comment.patient.id) {
                Navigator.pop(context);
                final isSuccess = await _deleteComment();
                if (isSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Comment deleted'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                  });
                }
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('You cannot delete other people\'s comment!'),
                      duration: Duration(seconds: 1),
                    ));
                  }
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Future<bool> _deleteComment() async {
    await patientCommentController
        .handleRemoveComment(
            commentId: widget.comment.id, postId: widget.comment.post)
        .then((value) async {
      await postController.handleGetOnePost(widget.comment.post);
    });
    return true;
  }
}
