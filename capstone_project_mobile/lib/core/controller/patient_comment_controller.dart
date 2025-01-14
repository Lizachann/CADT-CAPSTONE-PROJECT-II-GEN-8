import 'package:capstone_project_mobile/core/model/dto/create_comment_dto.dart';
import 'package:capstone_project_mobile/core/model/patient_comment_model.dart';
import 'package:capstone_project_mobile/core/services/get_service.dart';
import 'package:capstone_project_mobile/core/services/post_service.dart';
import 'package:get/get.dart';

class PatientCommentController extends GetxController {
  final _allComments = Future<List<ParentCommentV2>>.value([]).obs;

  Rx<Future<List<ParentCommentV2>>> get getAllComments => _allComments;

  void setAllComments(var newComments) {
    _allComments.value = Future.value(newComments);
  }

  Future<void> handleGetAllParentComments({required String postId}) async {
    List<ParentCommentV2> parentComments =
        await GetService.fetchCommentByPostV2(postId: postId)
            .then((value) => value)
            .catchError((err) => throw err);

    setAllComments(parentComments);
  }

  Future<void> handleCreateComment(
      {required CreateCommentDto createCommentDto}) async {
    var res = await PostService.createComment(createCommentDto)
        .then((value) => value)
        .catchError((err) => throw err);

    await handleGetAllParentComments(postId: createCommentDto.post);

    return res;
  }

  Future<void> handleRemoveComment(
      {required String commentId, required String postId}) async {
    var res = await PostService.removeComment(commentId)
        .then((value) => value)
        .catchError((err) => throw err);

    await handleGetAllParentComments(postId: postId);

    return res;
  }
}
