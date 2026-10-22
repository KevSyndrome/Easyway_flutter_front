import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CreatePotholeScreen extends StatelessWidget {
  const CreatePotholeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar bache'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Formulario de reporte',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              'Aquí irá el formulario',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}