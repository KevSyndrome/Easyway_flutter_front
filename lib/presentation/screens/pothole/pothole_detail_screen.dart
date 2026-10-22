import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/potholes_provider.dart';
import '../../widgets/common/loading_widget.dart';

class PotholeDetailScreen extends ConsumerWidget {
  final int potholeId;

  const PotholeDetailScreen({
    super.key,
    required this.potholeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final potholeAsync =
    ref.watch(potholeDetailProvider(potholeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del bache'),
      ),
      body: potholeAsync.when(
        data: (pothole) {
          if (pothole == null) {
            return const Center(child: Text('No encontrado'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${pothole.id}'),
                Text('Severidad: ${pothole.severityLabel}'),
                Text('Estado: ${pothole.statusLabel}'),
                Text(
                    'Ubicación: ${pothole.latitude}, ${pothole.longitude}'),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}