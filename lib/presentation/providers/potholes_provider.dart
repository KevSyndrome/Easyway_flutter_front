import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/pothole_model.dart';
import '../../services/api_service.dart';
import 'auth_provider.dart';

class PotholesState {
  final List<Pothole> potholes;
  final bool isLoading;
  final String? error;
  final bool hasMore;

  const PotholesState({
    this.potholes = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
  });

  PotholesState copyWith({
    List<Pothole>? potholes,
    bool? isLoading,
    String? error,
    bool? hasMore,
  }) {
    return PotholesState(
      potholes: potholes ?? this.potholes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

final potholesProvider = StateNotifierProvider<PotholesNotifier, PotholesState>(
  (ref) {
    final apiService = ref.watch(apiServiceProvider);
    return PotholesNotifier(apiService);
  },
);

class PotholesNotifier extends StateNotifier<PotholesState> {
  final ApiService _apiService;
  int _page = 0;

  PotholesNotifier(this._apiService) : super(const PotholesState());

  Future<void> loadPotholes({
    double? lat,
    double? lon,
    bool refresh = false,
  }) async {
    if (state.isLoading) return;
    if (!refresh && !state.hasMore) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final queryParams = <String, String>{
        'skip': (_page * 20).toString(),
        'limit': '20',
      };
      if (lat != null && lon != null) {
        queryParams['lat'] = lat.toString();
        queryParams['lon'] = lon.toString();
        queryParams['radius_km'] = '10';
      }
      final response = await _apiService.get(
        '/potholes',
        queryParams: queryParams,
      );
      if (response.success && response.data != null) {
        final List<dynamic> data = response.data is List ? response.data : [];
        final potholes = data.map((json) => Pothole.fromJson(json)).toList();
        state = state.copyWith(
          potholes: refresh ? potholes : [...state.potholes, ...potholes],
          isLoading: false,
          hasMore: potholes.length >= 20,
        );
        if (refresh) {
          _page = 1;
        } else {
          ++_page;
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error?.message ?? 'Error al cargar',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Error de conexión');
    }
  }

  Future<bool> createPothole({
    required double latitude,
    required double longitude,
    required int severity,
    String? address,
    String? description,
    String? imageUrl,
  }) async {
    try {
      final response = await _apiService.post(
        '/potholes',
        body: {
          'latitude': latitude,
          'longitude': longitude,
          'severity': severity,
          'address': address,
          'description': description,
          'image_url': imageUrl,
        },
      );
      if (response.success && response.data != null) {
        final pothole = Pothole.fromJson(response.data);
        state = state.copyWith(potholes: [pothole, ...state.potholes]);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> refresh() async => loadPotholes(refresh: true);
}

final potholeDetailProvider = FutureProvider.family<Pothole?, int>((
  ref,
  potholeId,
) async {
  final apiService = ref.watch(apiServiceProvider);
  final response = await apiService.get('/potholes/$potholeId');
  if (response.success && response.data != null)
    return Pothole.fromJson(response.data);
  return null;
});
