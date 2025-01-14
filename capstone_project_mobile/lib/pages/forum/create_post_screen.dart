import 'dart:io';

import 'package:capstone_project_mobile/components/buttons/my_text_button.dart';
import 'package:capstone_project_mobile/components/cards/profile_picture_card.dart';
import 'package:capstone_project_mobile/components/dialogs/error_dialog.dart';
import 'package:capstone_project_mobile/components/inputs/my_text_field.dart';
import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/controller/post_controller.dart';
import 'package:capstone_project_mobile/core/model/error_response.dart';
import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:capstone_project_mobile/pages/login/login_email_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  AuthController authController = Get.put(AuthController());
  dynamic errors;
  TextEditingController bodyController = TextEditingController();
  List<XFile> postImages = [];
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    if (authController.user.value == null) {
      return const LoginEmail();
    }

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Create Post',
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // User Profile
            Row(
              children: [
                // Profile pic
                ProfilePictureCard(
                  imgPath: authController.user.value!.profileImg,
                ),

                const SizedBox(
                  width: 12,
                ),

                // Username
                Text(
                  authController.user.value!.username,
                  style: textTheme.displayMedium,
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            // Body field
            MyTextField(
              controller: bodyController,
              hintText: "Write what's on your mind",
            ),

            const SizedBox(
              height: 20,
            ),

            // Image upload field
            MyTextButton(
              padding: const EdgeInsets.all(8),
              text: "Upload Image",
              icon: Icon(
                LucideIcons.upload,
                color: colorScheme.tertiary,
              ),
              onTap: () async {
                List<XFile>? images = await picker.pickMultiImage();
                // if (images.isEmpty) return;
                setState(() {
                  postImages = images;
                });
              },
            ),

            if (postImages.isNotEmpty)
              SizedBox(
                height: 250, // Set a height for the horizontal scrollable area
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: postImages.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.grey.shade200,
                          child: Image.file(
                            File(postImages[index].path),
                            height: 250,
                            width: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        _buildTrashButton(context, imageIndex: index),
                      ],
                    ),
                  ),
                ),
              )
            else
              const Text(''),

            const SizedBox(
              height: 20,
            ),

            // Post Button
            PostButton(
              postImages: postImages,
              bodyController: bodyController,
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrashButton(BuildContext context, {required int imageIndex}) {
    return Positioned(
      bottom: 12,
      right: 12,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              width: 4,
              color: Colors.red,
            ),
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                postImages.removeAt(imageIndex);
              });
            },
            icon: const Icon(
              LucideIcons.trash2,
              color: Colors.red,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  final List<XFile> postImages;
  final TextEditingController bodyController;

  const PostButton({
    super.key,
    required this.postImages,
    required this.bodyController,
  });

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.put(PostController());

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(colorScheme.primary),
      ),
      onPressed: () async {
        await postController
            .handleCreatePost(body: bodyController.text, postImages: postImages)
            .then((value) {
          Navigator.of(context).pop();
        }).catchError((err) {
          ErrorResponse errorResponse = ErrorResponse.fromJson(err);
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              text: errorResponse.validationMessages.toString(),
            ),
          );
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            'Post',
            style: textTheme.displayMedium!.copyWith(
              color: colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
