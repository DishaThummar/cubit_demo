import 'package:dio/dio.dart';
import 'package:e_vital/configs/api_config.dart';

const String baseUrl = ApiConfig.baseUrl;

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print('Request: ${options.method} ${options.uri}');
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print('Response: ${response.statusCode} ${response.data}');
        handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        print('Error: ${e.message}');
        handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get<T>(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response<T>> post<T>(String endpoint,
      {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post<T>(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response<T>> put<T>(String endpoint,
      {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.put<T>(endpoint, data: data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response<T>> delete<T>(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.delete<T>(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
