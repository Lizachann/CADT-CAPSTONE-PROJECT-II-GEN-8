class ErrorResponse {
  int? statusCode;
  String? timeStamp;
  String? path;
  String? errorType;
  List<dynamic>? messages;
  List<dynamic>? validationMessages;

  ErrorResponse({
    this.statusCode,
    this.timeStamp,
    this.path,
    this.errorType,
    this.messages,
    this.validationMessages,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'statusCode': int statusCode,
        'timestamp': String timeStamp,
        'path': String path,
        'errorType': String errorType,
      } =>
        ErrorResponse(
          statusCode: statusCode,
          timeStamp: timeStamp,
          path: path,
          errorType: errorType,
          messages: json['messages'],
          validationMessages: json['validationMessages'],
        ),
      _ => throw const FormatException('Failed to load error')
    };
  }
}