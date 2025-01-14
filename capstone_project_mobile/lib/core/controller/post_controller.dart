import 'dart:async';
import 'dart:io';

import 'package:capstone_project_mobile/core/controller/auth_controller.dart';
import 'package:capstone_project_mobile/core/model/dto/create_post.dart';
import 'package:capstone_project_mobile/core/model/post.dart';
import 'package:capstone_project_mobile/core/services/get_service.dart';
import 'package:capstone_project_mobile/core/services/post_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  final _allPosts = Future<List<Post>>.value([]).obs;

  void setAllPosts(var newPosts) {
    _allPosts.value = Future.value(newPosts);
  }

  Rx<Future<List<Post>>> get getAllPosts => _allPosts;

  final _onePost = Future<Post?>.value().obs;

  Rx<Future<Post?>> get getOnePost => _onePost;
  void setOnePost(var newPost) {
    _onePost.value = Future.value(newPost);
  }

  Future<void> handleGetAllPosts() async {
    List<Post> posts = await GetService.fetchPosts()
        .then((value) => value)
        .catchError((err) => throw err);

    setAllPosts(posts);
  }

  Future<void> handleGetOnePost(String postId) async {
    Post post = await GetService.fetchOnePost(postId)
        .then((value) => value)
        .catchError((err) {
      throw err;
    });
    setOnePost(post);
  }

  List<File> getAllPaths({List<XFile>? postImages}) {
    List<File> filePaths = [];
    for (int i = 0; i < postImages!.length; i++) {
      filePaths.add(File(postImages[i].path));
    }

    return filePaths;
  }

  Future handleCreatePost({
    required String body,
    List<XFile>? postImages,
  }) async {
    final user = authController.user.value!;
    var res = await PostService.createPost(CreatePost(
      body: body,
      patient: user.id,
      postPhotos: getAllPaths(postImages: postImages ?? []),
    )).then(
      (value) async {
        return value;
      },
    ).catchError((err) {
      throw err;
    });

    await handleGetAllPosts();

    return res;
  }

  Future handleGetLikeCount(String postId) async {
    Post post = await GetService.fetchOnePost(postId);
    return post.likeCount;
  }

  Future handleLikePost(String postId) async {
    final user = authController.user;

    await PostService.likePost(
      id: postId,
      patientId: user.value!.id,
    ).catchError((err) => throw err);
  }
}
