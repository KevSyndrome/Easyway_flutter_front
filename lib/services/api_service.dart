import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants/app_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final http.Client _client = http.Client();

  String _baseUrl = AppConstants.apiBaseUrl;
  String? _accessToken;
  String? _refreshToken;
  bool _isRefreshing = false;

  ApiService._internal();

  Future<void> init() async {
    _accessToken = await _storage.read(key: AppConstants.accessTokenKey);
    _refreshToken = await _storage.read(key: AppConstants.refreshTokenKey);
  }

  Map<String, String> get _baseHeaders {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (_accessToken != null) headers['Authorization'] = 'Bearer $_accessToken';
    return headers;
  }

  Future<ApiResponse> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl$endpoint',
    ).replace(queryParameters: queryParams);
    return _request(() => _client.get(uri, headers: _baseHeaders));
  }

  Future<ApiResponse> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    return _request(
      () => _client.post(
        uri,
        headers: _baseHeaders,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  Future<ApiResponse> patch(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    return _request(
      () => _client.patch(
        uri,
        headers: _baseHeaders,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  Future<ApiResponse> _request(
    Future<http.Response> Function() requestFn,
  ) async {
    try {
      final response = await requestFn();
      return _parseResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        error: ApiError(message: 'Error de conexión: $e', statusCode: 0),
      );
    }
  }

  ApiResponse _parseResponse(http.Response response) {
    dynamic data;
    try {
      if (response.body.isNotEmpty) data = jsonDecode(response.body);
    } catch (e) {}
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ApiResponse(success: true, data: data);
    }
    String message = 'Error desconocido';
    if (data is Map) message = data['detail'] ?? data['message'] ?? message;
    return ApiResponse(
      success: false,
      error: ApiError(message: message, statusCode: response.statusCode),
    );
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await _storage.write(key: AppConstants.accessTokenKey, value: accessToken);
    await _storage.write(
      key: AppConstants.refreshTokenKey,
      value: refreshToken,
    );
  }

  Future<void> logout() async {
    _accessToken = null;
    _refreshToken = null;
    await _storage.delete(key: AppConstants.accessTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }

  bool get isAuthenticated => _accessToken != null;
  String? get accessToken => _accessToken;
}

class ApiResponse {
  final bool success;
  final dynamic data;
  final ApiError? error;
  ApiResponse({required this.success, this.data, this.error});
}

class ApiError {
  final String message;
  final int statusCode;
  ApiError({required this.message, required this.statusCode});
}
