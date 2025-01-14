import 'dart:io';

import 'package:capstone_project_mobile/constants/api_route_constant.dart';
import 'package:capstone_project_mobile/core/model/dto/create_appointment.dart';
import 'package:capstone_project_mobile/core/model/dto/create_comment_dto.dart';
import 'package:capstone_project_mobile/core/model/dto/create_post.dart';
import 'package:capstone_project_mobile/core/model/dto/create_therapist_singup.dart';
import 'package:capstone_project_mobile/core/model/dto/create_total_score.dart';
import 'package:capstone_project_mobile/core/services/http_service.dart';
import 'package:capstone_project_mobile/utils/api_helper.dart';
import 'package:http/http.dart';

class PostService {
  static Future createAppointment(CreateAppointment body) async {
    HttpService httpService = HttpService(path: ApiRoute.appointments.name);

    var HttpResponse(:httpRes, :jsonData) = await httpService.httpPost(
      body: {
        'symptoms': body.symptoms,
        'patient': body.patient,
        'therapist': body.therapist,
        'scheduleDate': body.scheduleDate,
        'start_time': body.startTime,
        'end_time': body.endTime,
        'duration': body.duration
      },
    );

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future createPost(CreatePost body) async {
    HttpService httpService = HttpService(path: ApiRoute.posts.name);

    List<String> files = [];

    if (body.postPhotos!.isNotEmpty) {
      for (int i = 0; i < body.postPhotos!.length; i++) {
        files.add(body.postPhotos![i].path);
      }
    }

    if (files.isNotEmpty) {
      return await uploadPostPhotos(httpService, body, files);
    }
    var HttpResponse(:httpRes, :jsonData) =
        await httpService.httpMultiPartRequest(
      body: {
        'body': body.body,
        'patient': body.patient,
      },
      files: [],
    );
    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future<StreamedResponse> uploadPostPhotos(
      HttpService httpService, CreatePost body, List<String> files) async {
    var MultipartResponse(:jsonData, :response) =
        await httpService.httpMultiPartRequest(
      body: {
        'body': body.body,
        'patient': body.patient,
      },
      files: files,
    );
    if (ApiHelper.isOk(response.statusCode)) {
      return response;
    } else {
      throw jsonData;
    }
  }

  static Future likePost(
      {required String id, required String patientId}) async {
    HttpService httpService =
        HttpService(path: "${ApiRoute.likePosts.name}/$id");

    var HttpResponse(:httpRes, :jsonData) = await httpService.httpPatch(
      body: {
        'patient': patientId,
        'post': id,
      },
    );

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future sendTotalScore(SaveTotalScore body) async {
    final httpService = HttpService(path: ApiRoute.stressMonitor.name);

    var HttpResponse(:httpRes, :jsonData) = await httpService.httpPost(
      body: {
        'total_score': body.getTotalScore,
        'patient': body.getPatient,
      },
    );
    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future createTherapistSignup(TherapistSignUp body) async {
    HttpService httpService =
        HttpService(path: '${ApiRoute.therapists.name}/registration');

    List<String> files = [];
    if (body.therapistApplicationPhotos != null) {
      for (File photo in body.therapistApplicationPhotos!) {
        files.add(photo.path);
      }
    }

    if (files.isNotEmpty) {
      return await uploadTherapistSignupPhotos(httpService, body, files);
    }

    var HttpResponse(:httpRes, :jsonData) =
        await httpService.httpMultiPartRequestTherapist(
      body: {
        'first_name': body.firstName,
        'last_name': body.lastName,
        'email': body.email,
        'status': body.status,
      },
      files: [],
    );
    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future createComment(CreateCommentDto createCommentDto) async {
    final httpService = HttpService(path: ApiRoute.patientComments.name);

    var HttpResponse(:jsonData, :httpRes) = await httpService.httpPost(body: {
      'content': createCommentDto.content,
      'patient': createCommentDto.patient,
      'post': createCommentDto.post,
    });

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future<StreamedResponse> uploadTherapistSignupPhotos(
      HttpService httpService, TherapistSignUp body, List<String> files) async {
    var MultipartResponse(:jsonData, :response) =
        await httpService.httpMultiPartRequestTherapist(
      body: {
        'first_name': body.firstName,
        'last_name': body.lastName,
        'email': body.email,
        'status': body.status,
      },
      files: files,
    );

    if (ApiHelper.isOk(response.statusCode)) {
      return response;
    } else {
      throw jsonData;
    }
  }

  static Future removeComment(String commentId) async {
    final httpService =
        HttpService(path: "${ApiRoute.removeComment.name}/$commentId");

    var HttpResponse(:jsonData, :httpRes) =
        await httpService.httpPatch(body: {});

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return httpRes;
    } else {
      throw jsonData;
    }
  }

  static Future mindCheckUp(answersMap) async {
    HttpService httpService = HttpService(path: ApiRoute.mindCheckUp.name);

    Map<String, dynamic> finalAnswersMap = {
      'patient': '63686861790123456789abcd', // Change patient object id
      ...answersMap, // Spread the existing attributes
    };

    var HttpResponse(:httpRes, :jsonData) =
        await httpService.httpPost(body: finalAnswersMap);

    if (ApiHelper.isOk(httpRes.statusCode)) {
      return jsonData['data'];
    } else {
      throw jsonData;
    }
  }
}
