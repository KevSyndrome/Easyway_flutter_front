import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // Sin valores por defecto: se configuran en .env (ver .env.example).
  static String get apiBaseUrl => dotenv.get('API_BASE_URL');
  static String get websocketUrl => dotenv.get('WEBSOCKET_URL');
  static const int httpTimeout = 30;

  static const double defaultLatitude = 19.4326;
  static const double defaultLongitude = -99.1332;
  // Los edificios 3D de Mapbox Standard aparecen a partir de zoom ~15.
  static const double defaultZoom = 16.0;
  static const double defaultPitch = 60.0;
  static const double minZoom = 3.0;
  static const double maxZoom = 18.0;
  static const double searchRadiusKm = 10.0;

  static const int pageSize = 20;

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String devModeKey = 'dev_mode';
}
