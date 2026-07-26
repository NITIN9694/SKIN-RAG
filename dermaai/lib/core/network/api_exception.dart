import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Connection timed out with the server.");
      case DioExceptionType.badResponse:
        final response = error.response;
        return ApiException(
          message: response?.data?['message'] ?? "An unexpected server error occurred.",
          statusCode: response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException(message: "Request cancelled by user.");
      default:
        return ApiException(message: "Check your internet connection and try again.");
    }
  }
}
