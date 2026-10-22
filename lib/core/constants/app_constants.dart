class AppConstants {
  static const String apiBaseUrl = 'http://localhost:8001/api/v1';
  static const String websocketUrl = 'ws://localhost:8001';
  static const int httpTimeout = 30;

  static String mapboxToken = '';

  static const double defaultLatitude = 19.4326;
  static const double defaultLongitude = -99.1332;
  static const double defaultZoom = 13.0;
  static const double minZoom = 3.0;
  static const double maxZoom = 18.0;
  static const double searchRadiusKm = 10.0;

  static const int pageSize = 20;

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String devModeKey = 'dev_mode';
}
