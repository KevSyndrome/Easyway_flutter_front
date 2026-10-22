import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;

  const LoadingWidget({super.key, this.message, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message!, style: TextStyle(color: AppColors.onSurfaceVariant)),
          ],
        ],
      ),
    );
  }
}
