enum ApiRoute {
  auth("auth"),
  patients("patients"),
  therapists("therapists"),
  appointments("appointments"),
  posts("posts"),
  likePosts("like-posts"),
  patientComments("patient-comments"),
  newPatientComments("patient-comments/comments-new"),
  removeComment("patient-comments/remove-comment"),
  creditPackages("credits"),
  stripe("stripe"),
  stressMonitor("stress-monitor"),
  registerPatient("auth/patient/register"),
  login("auth/patient/login"),
  mindCheckUp("mind-checkup");

  final String name;

  const ApiRoute(this.name);

  static ApiRoute? fromString(String route) {
    for (final entry in ApiRoute.values) {
      if (entry.name == route) {
        return entry;
      }
    }
    return null;
  }
}
