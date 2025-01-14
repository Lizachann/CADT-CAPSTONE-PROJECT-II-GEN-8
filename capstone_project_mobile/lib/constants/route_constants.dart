enum RouteConstant {
  homePage("/home"),
  forumPage("/forum"),
  therapistsPage("/therapists"),
  resourcePage("/resource"),
  profilePage("/profile"),
  postDetailPage("/post-detail"),
  commentPage("/comments");

  final String name;

  const RouteConstant(this.name);

  static RouteConstant? fromString(String route) {
    for (final entry in RouteConstant.values) {
      if (entry.name == route) {
        return entry;
      }
    }
    return null;
  }
}
