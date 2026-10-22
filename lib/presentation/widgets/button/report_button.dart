import 'package:flutter/material.dart';
import '../../screens/pothole/create_photole_screen.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CreatePotholeScreen(),
          ),
        );
      },
      icon: const Icon(Icons.add_location_alt),
      label: const Text('Reportar bache'),
    );
  }
}