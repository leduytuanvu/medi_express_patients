class ApiResponse<T> {
  final T? data;
  final int code;
  final String message;

  ApiResponse({
    required this.data,
    required this.code,
    required this.message,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'data': data != null ? toJsonT(data as T) : null,
      'code': code,
      'message': message,
    };
  }
}
