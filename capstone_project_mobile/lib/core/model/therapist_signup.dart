// import 'package:capstone_project_mobile/core/model/base_model.dart';
// import 'package:capstone_project_mobile/core/model/post_photo.dart';

// class TherapistSignUp extends BaseModel {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String status;
//   final List<PostPhoto>? therapistApplicationPhotos;

//   TherapistSignUp({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     this.therapistApplicationPhotos,
//     required this.status,
//     required super.id,
//     required super.createdAt,
//     required super.updatedAt,
//   });

//   factory TherapistSignUp.fromJson(Map<String, dynamic> json) {
//     List<PostPhoto> listPhotos = [];
//     if (json['therapistApplicationPhotos'] != null) {
//       for (var eachPostPhoto in json['therapistApplicationPhotos']) {
//         listPhotos.add(PostPhoto.fromJson(eachPostPhoto));
//       }
//     }

//     return switch (json) {
//       {
//         '_id': String id,
//         'createdAt': String createdAt,
//         'updatedAt': String updatedAt,
//         'first_name': String firstName,
//         'last_name': String lastName,
//         'email': String email,
//         'status': String status,
//       } =>
//         TherapistSignUp(
//           firstName: firstName,
//           id: id,
//           createdAt: createdAt,
//           updatedAt: updatedAt,
//           lastName: lastName,
//           email: email,
//           status: status,
//           therapistApplicationPhotos: listPhotos,
//         ),
//       _ => throw const FormatException('Failed to load Therapist Signup'),
//     };
//   }
// }
