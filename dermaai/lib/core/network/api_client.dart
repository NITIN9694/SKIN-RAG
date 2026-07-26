import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'api_exception.dart';

class ApiClient {
  final Dio _dio;
  String _customBaseUrl = AppConstants.baseUrl;

  ApiClient(this._dio) {
    _dio.options.baseUrl = _customBaseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {'Accept': 'application/json'};
  }

  void updateBaseUrl(String newUrl) {
    if (newUrl.isNotEmpty) {
      _customBaseUrl = newUrl;
      _dio.options.baseUrl = newUrl;
    }
  }
  String get currentBaseUrl => _customBaseUrl;

   Future<Response> postMultipart(String endpoint, FormData formData) async {
    try {
      return await _dio.post(endpoint, data: formData);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
