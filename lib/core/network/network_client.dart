import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';
import '../storage/storage_service.dart';

// re-export for convenience
export '../constants/app_constants.dart' show ApiEndpoints;

// ── API Response wrapper ──────────────────────────────────────────────────────

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final List<dynamic> errors;

  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors = const [],
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromData,
  ) {
    return ApiResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: fromData != null && json['data'] != null
          ? fromData(json['data'])
          : json['data'] as T?,
      errors: json['errors'] as List<dynamic>? ?? [],
    );
  }
}

// ── API Exception ─────────────────────────────────────────────────────────────

class ApiException implements Exception {
  final String message;
  final String code;
  final int statusCode;

  const ApiException({
    required this.message,
    this.code = 'UNKNOWN',
    this.statusCode = 500,
  });

  @override
  String toString() => message;

  factory ApiException.fromDio(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const ApiException(
        message: 'درخواست بیش از حد طول کشید. دوباره تلاش کن.',
        code: 'TIMEOUT',
        statusCode: 408,
      );
    }

    if (e.type == DioExceptionType.connectionError) {
      return const ApiException(
        message: 'ارتباط با اینترنت برقرار نیست.',
        code: 'NO_CONNECTION',
        statusCode: 0,
      );
    }

    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      return ApiException(
        message: data['message'] as String? ?? 'خطایی رخ داد.',
        code: e.response?.statusCode.toString() ?? 'UNKNOWN',
        statusCode: e.response?.statusCode ?? 500,
      );
    }

    return const ApiException(
      message: 'خطایی رخ داد. دوباره تلاش کن.',
      code: 'UNKNOWN',
    );
  }
}

// ── Network Client ────────────────────────────────────────────────────────────

class NetworkClient {
  static final NetworkClient _instance = NetworkClient._internal();
  factory NetworkClient() => _instance;
  NetworkClient._internal();

  late final Dio _dio;
  final _storage = StorageService();

  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept':       'application/json',
      },
    ));

    // auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onError:   _onError,
    ));

    // logger (debug only)
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
      ));
    }
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // try refresh
      try {
        final refreshToken = await _storage.getRefreshToken();
        if (refreshToken == null) {
          await _storage.clear();
          handler.reject(err);
          return;
        }

        final refreshDio = Dio(BaseOptions(baseUrl: AppConstants.baseUrl));
        final res = await refreshDio.post(
          ApiEndpoints.refresh,
          data: {'refresh_token': refreshToken},
        );

        final newToken = res.data['data']['token'] as String?;
        final newRefresh = res.data['data']['refresh_token'] as String?;

        if (newToken != null) {
          await _storage.saveToken(newToken);
          if (newRefresh != null) await _storage.saveRefreshToken(newRefresh);

          // retry original request
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          final retry = await _dio.fetch(err.requestOptions);
          handler.resolve(retry);
          return;
        }
      } catch (_) {
        await _storage.clear();
      }
    }
    handler.next(err);
  }

  // ── HTTP methods ──────────────────────────────────────────────────────────

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(path, queryParameters: params);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
