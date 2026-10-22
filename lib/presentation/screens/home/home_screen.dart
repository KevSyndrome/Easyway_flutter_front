import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/potholes_provider.dart';

import '../../widgets/common/pothole_bottom_sheet.dart';
import '../../widgets/button/report_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(potholesProvider.notifier)
          .loadPotholes(
            lat: AppConstants.defaultLatitude,
            lon: AppConstants.defaultLongitude,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final potholesState = ref.watch(potholesProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EasyWay'),
        actions: [
          if (authState.isDevMode)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'DEV',
                style: TextStyle(
                  color: AppColors.primaryYellow,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(potholesProvider.notifier).refresh(),
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: MapWidget(
              key: const ValueKey('map'),
              styleUri: MapboxStyles.MAPBOX_STREETS,
              viewport: CameraViewportState(
                center: Point(
                  coordinates: Position(
                    AppConstants.defaultLongitude,
                    AppConstants.defaultLatitude,
                  ),
                ),
                zoom: AppConstants.defaultZoom,
              ),
            ),
          ),

          // Sin Positioned: la hoja necesita la altura completa del Stack para arrastrarse.
          PotholeBottomSheet(
            potholes: potholesState.potholes,
            isLoading: potholesState.isLoading,
          ),
        ],
      ),

      floatingActionButton: const ReportButton(),
    );
  }
}
