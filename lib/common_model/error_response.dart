class ErrorResponse {
  final int statusCode;
  final String message;

  ErrorResponse({required this.statusCode, required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        message: json['message'],
        statusCode: json['status_code'],
      );
}