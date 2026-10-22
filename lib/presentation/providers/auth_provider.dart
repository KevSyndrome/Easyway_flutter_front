import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

enum AuthStatus { initial, authenticated, unauthenticated, loading }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? error;
  final bool isDevMode;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
    this.isDevMode = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
    bool? isDevMode,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
      isDevMode: isDevMode ?? this.isDevMode,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
}

final devUser = User(
  id: 999,
  email: 'dev@easyway.local',
  username: 'dev_user',
  fullName: 'Desarrollador',
  status: 'active',
  isSuperuser: true,
  createdAt: DateTime.now(),
);

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthNotifier(apiService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;

  AuthNotifier(this._apiService) : super(const AuthState()) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    state = state.copyWith(status: AuthStatus.loading);
    await _apiService.init();
    if (_apiService.isAuthenticated) {
      try {
        final response = await _apiService.get('/auth/me');
        if (response.success && response.data != null) {
          state = state.copyWith(
            status: AuthStatus.authenticated,
            user: User.fromJson(response.data),
          );
        } else {
          state = state.copyWith(status: AuthStatus.unauthenticated);
        }
      } catch (e) {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final response = await _apiService.post(
        '/auth/login',
        body: {'email': email, 'password': password},
      );
      if (response.success && response.data != null) {
        await _apiService.saveTokens(
          accessToken: response.data['access_token'],
          refreshToken: response.data['refresh_token'],
        );
        final userResponse = await _apiService.get('/auth/me');
        if (userResponse.success && userResponse.data != null) {
          state = state.copyWith(
            status: AuthStatus.authenticated,
            user: User.fromJson(userResponse.data),
          );
          return true;
        }
      }
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: response.error?.message ?? 'Error al iniciar sesión',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: 'Error de conexión',
      );
      return false;
    }
  }

  Future<void> loginAsDev() async {
    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: devUser,
      isDevMode: true,
    );
  }

  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout');
    } catch (e) {}
    await _apiService.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}
