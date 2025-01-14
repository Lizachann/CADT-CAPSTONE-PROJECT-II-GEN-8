enum StatusConstant {
  requested("requested"),
  scheduled("scheduled"),
  completed("completed"),
  rejected("rejected");

  final String name;

  const StatusConstant(this.name);

  static StatusConstant? fromString(String route) {
    for (final entry in StatusConstant.values) {
      if (entry.name == route) {
        return entry;
      }
    }
    return null;
  }
}
