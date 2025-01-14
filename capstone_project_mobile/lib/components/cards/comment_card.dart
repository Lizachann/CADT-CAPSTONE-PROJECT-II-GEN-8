import 'package:capstone_project_mobile/components/comment_profile_header.dart';
import 'package:capstone_project_mobile/core/controller/patient_comment_controller.dart';
import 'package:capstone_project_mobile/core/model/patient_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentCard extends StatelessWidget {
  final ParentCommentV2 comment;
  CommentCard({
    super.key,
    required this.comment,
  });
  final PatientCommentController patientCommentController =
      Get.put(PatientCommentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          // _buildProfileHeader(context, profileImg: comment.patient.profileImg),
          CommentProfileHeader(comment: comment),

          const SizedBox(
            height: 16,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.content),
              const SizedBox(
                height: 16,
              ),
            ],
          )
        ],
      ),
    );
  }
}
