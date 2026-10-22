import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'loading_widget.dart';
import 'pothole_card.dart';
import '../../screens/pothole/pothole_detail_screen.dart';

class PotholeList extends StatelessWidget {
  final List potholes;
  final bool isLoading;

  const PotholeList({
    super.key,
    required this.potholes,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && potholes.isEmpty) {
      return const LoadingWidget();
    }

    if (potholes.isEmpty) {
      return Center(
        child: Text(
          'No hay baches reportados',
          style: TextStyle(color: AppColors.onSurfaceVariant),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: potholes.length,
      itemBuilder: (_, i) {
        final pothole = potholes[i];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: PotholeCard(
            pothole: pothole,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PotholeDetailScreen(
                    potholeId: pothole.id,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}