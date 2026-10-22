import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'loading_widget.dart';
import 'pothole_card.dart';
import '../../screens/pothole/pothole_detail_screen.dart';

class PotholeBottomSheet extends StatelessWidget {
  final List potholes;
  final bool isLoading;

  const PotholeBottomSheet({
    super.key,
    required this.potholes,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // barra de arrastre
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Baches cercanos',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${potholes.length} reportes',
                      style: TextStyle(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: isLoading && potholes.isEmpty
                    ? const LoadingWidget()
                    : potholes.isEmpty
                    ? Center(
                        child: Text(
                          'No hay baches',
                          style: TextStyle(color: AppColors.onSurfaceVariant),
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: potholes.length,
                        itemBuilder: (_, i) {
                          final pothole = potholes[i];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
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
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
