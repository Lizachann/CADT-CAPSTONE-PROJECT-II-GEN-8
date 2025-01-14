// import 'dart:io';

// import 'package:capstone_project_mobile/core/model/dto/create_therapist_singup.dart';
// import 'package:capstone_project_mobile/core/model/therapist.dart';
// import 'package:capstone_project_mobile/core/services/get_service.dart';
// import 'package:capstone_project_mobile/core/services/post_service.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class TherapistController extends GetxController {
//   List<Therapist> _allTherapiss = [];

//   void setAllTherapists(List<Therapist> newTherapists) {
//     _allTherapiss = newTherapists;
//     update();
//   }

//   List<Therapist> get getAllTherapists => _allTherapiss;

//   Future<List<Therapist>> handleGetAllTherapists() async {
//     List<Therapist> therapists = await GetService.fetchTherapists()
//         .then((value) => value)
//         .catchError((err) => throw err);

//     setAllTherapists(therapists);

//     return _allTherapiss;
//   }

//   List<File> getAllPaths({List<XFile>? postImages}) {
//     List<File> filePaths = [];
//     for (int i = 0; i < postImages!.length; i++) {
//       filePaths.add(File(postImages[i].path));
//     }

//     return filePaths;
//   }

//   Future handleTherapistSignup({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String status,
//     List<XFile>? postImages,
//   }) async {
//     var res = await PostService.createTherapistSignup(TherapistSignUp(
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       status: status,
//       therapistApplicationPhotos: getAllPaths(postImages: postImages ?? []),
//     )).then(
//       (value) async {
//         return value;
//       },
//     ).catchError((err) {
//       throw err;
//     });

//     return res;
//   }
// }

import 'dart:io';

import 'package:capstone_project_mobile/core/model/dto/create_therapist_singup.dart';
import 'package:capstone_project_mobile/core/model/therapist.dart';
import 'package:capstone_project_mobile/core/services/get_service.dart';
import 'package:capstone_project_mobile/core/services/post_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TherapistController extends GetxController {
  List<Therapist> _allTherapists = [];

  void setAllTherapists(List<Therapist> newTherapists) {
    _allTherapists = newTherapists;
    update();
  }

  List<Therapist> get getAllTherapists => _allTherapists;

  Future<List<Therapist>> handleGetAllTherapists() async {
    List<Therapist> therapists = await GetService.fetchTherapists()
        .then((value) => value)
        .catchError((err) => throw err);

    setAllTherapists(therapists);

    return _allTherapists;
  }

  List<File> getAllPaths({List<XFile>? postImages}) {
    List<File> filePaths = [];
    if (postImages != null) {
      for (XFile postImage in postImages) {
        filePaths.add(File(postImage.path));
      }
    }
    return filePaths;
  }

  Future handleTherapistSignup({
    required String firstName,
    required String lastName,
    required String email,
    required String status,
    List<XFile>? postImages,
  }) async {
    List<File>? files =
        postImages != null ? getAllPaths(postImages: postImages) : null;
    // print(firstName);
    // print(lastName);
    // print(email);

    var res = await PostService.createTherapistSignup(TherapistSignUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      status: status,
      therapistApplicationPhotos: files,
    )).then((value) async {
      return value;
    }).catchError((err) {
      throw err;
    });

    return res;
  }
}
