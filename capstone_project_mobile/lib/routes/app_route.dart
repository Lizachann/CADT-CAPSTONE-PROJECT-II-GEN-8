import 'package:capstone_project_mobile/constants/route_constants.dart';
import 'package:capstone_project_mobile/core/bindings/post_binding.dart';
import 'package:capstone_project_mobile/core/bindings/therapist_binding.dart';
import 'package:capstone_project_mobile/pages/forum/comment/comment_page.dart';
import 'package:capstone_project_mobile/pages/forum/forum_page.dart';
import 'package:capstone_project_mobile/pages/home/home_page.dart';
import 'package:capstone_project_mobile/pages/profile/profile_page.dart';
import 'package:capstone_project_mobile/pages/resource/resource_page.dart';
import 'package:capstone_project_mobile/pages/therapists/therapists_page.dart';
import 'package:get/get.dart';

class AppRoute {  
  static final appPages = [
    const HomePage(),
    const ForumPage(),
    const TherapistsPage(),
    const ResourcePage(),
    const ProfilePage(),
    const CommentPage(),
  ];

  static final appTitle = [
    'Welcome to Chhantek!',
    'Forum',
    'Therapists',
    'Resources',
    'Profile',
    'Comment',
  ];

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: RouteConstant.homePage.name,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteConstant.forumPage.name,
      page: () => const ForumPage(),
      binding: PostBinding(),
    ),
    GetPage(
        name: RouteConstant.therapistsPage.name,
        page: () => const TherapistsPage(),
        binding: TherapistBinding()),
    GetPage(
      name: RouteConstant.resourcePage.name,
      page: () => const ResourcePage(),
    ),
    GetPage(
      name: RouteConstant.profilePage.name,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: RouteConstant.commentPage.name,
      page: () => const CommentPage(),
    ),
  ];
}
