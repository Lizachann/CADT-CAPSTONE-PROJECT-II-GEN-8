import 'package:capstone_project_mobile/components/buttons/my_text_button.dart';
import 'package:capstone_project_mobile/components/cards/profile_picture_card.dart';
import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/controller/post_controller.dart';
import 'package:capstone_project_mobile/core/model/error_response.dart';
import 'package:capstone_project_mobile/core/model/post.dart';
import 'package:capstone_project_mobile/pages/forum/post_detail_screen.dart';
import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:capstone_project_mobile/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final bool isCurrentPost;
  const PostCard({super.key, required this.post, required this.isCurrentPost});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final PostController postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    ImageHelper imageReqHelper = ImageHelper(imagePath: 'postPhotos');
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (!widget.isCurrentPost) {
          Get.to(() => PostDetailScreen(postId: widget.post.id));
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(
          children: [
            // header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // profile
                Row(
                  children: [
                    // profile
                    ProfilePictureCard(imgPath: widget.post.patient.profileImg),

                    const SizedBox(
                      width: 12,
                    ),

                    // name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.post.patient.username,
                            style: textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Post time
                        Text(
                          DateFormat.MMMd().add_jm().format(
                              DateTime.parse(widget.post.createdAt).toLocal()),
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),

                // more
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),

            // body
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // body text
                  Text(
                    widget.post.body,
                    style: textTheme.bodyLarge,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  if (widget.post.postPhotos.isNotEmpty)
                    SizedBox(
                      height: 250.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.post.postPhotos.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              imageReqHelper.getImage(
                                  filename:
                                      widget.post.postPhotos[index].filename),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(
                    height: 12,
                  ),

                  // buttons
                  Row(
                    children: [
                      FutureBuilder(
                        future:
                            postController.handleGetLikeCount(widget.post.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // var likeCount = snapshot.data!;
                            return GetBuilder<PostController>(
                              builder: (_) => LikeButton(
                                likeCount: widget.post.likeCount.toString(),
                                postId: widget.post.id,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return LikeButton(
                              likeCount: '-1',
                              postId: widget.post.id,
                            );
                          }
                          return LikeButton(
                            likeCount: '...',
                            postId: widget.post.id,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // Comment button
                      MyTextButton(
                        text:
                            '${widget.post.commentCount} Comment${widget.post.commentCount > 0 ? 's' : ""} ',
                        icon: Icon(
                          LucideIcons.messageCircle,
                          color: colorScheme.tertiary,
                        ),
                        onTap: () {},
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  final String likeCount;
  final String postId;
  LikeButton({
    super.key,
    required this.likeCount,
    required this.postId,
  });
  final PostController postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final user = authController.user;

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return MyTextButton(
      text: '${likeCount.toString()} Likes',
      icon: Icon(
        LucideIcons.heart,
        color: colorScheme.tertiary,
      ),
      onTap: () async {
        if (user.value == null) {
          return Get.to(() => const LoginEmail());
        } else {
          await postController.handleLikePost(postId).then((value) async {
            await postController.handleGetAllPosts();
            await postController.handleGetOnePost(postId);
          }).catchError((err) {
            ErrorResponse errorResponse = ErrorResponse.fromJson(err);
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                text: errorResponse.statusCode.toString(),
              ),
            );
          });
        }
      },
    );
  }
}
