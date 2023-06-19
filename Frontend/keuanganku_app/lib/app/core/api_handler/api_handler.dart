import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../config/api_config.dart';
import '../secure_storage/secure_storage.dart';

class ApiHandler {
  final Dio _dio;
  String? _token;
  final SecureStorage _storage;

  String? get token => _token;

  ApiHandler(this._dio, this._storage) {
    _dio.options.baseUrl = ApiConfig.BASE_URL;
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        if (kDebugMode) {
          log('Request: ${options.method} ${options.uri}');
          log('Headers: ${options.headers}');
          log('Data: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          log('Response: ${response.statusCode} ${response.statusMessage}');
          log('Headers: ${response.headers}');
          log('Data: ${response.data}');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          log('$error\n${error.response}');
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(path,
          queryParameters: queryParameters,
          data: data,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(path,
          queryParameters: queryParameters,
          data: data,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<void> init() async {
    _token = await _storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    _token = null;
    await _storage.delete(key: 'token');
  }
}
