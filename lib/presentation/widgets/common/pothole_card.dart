import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/pothole_model.dart';

class PotholeCard extends StatelessWidget {
  final Pothole pothole;
  final VoidCallback? onTap;

  const PotholeCard({super.key, required this.pothole, this.onTap});

  Color get _severityColor {
    switch (pothole.severity) {
      case 1:
        return AppColors.severityLow;
      case 2:
        return AppColors.severityMedium;
      case 3:
        return AppColors.severityHigh;
      case 4:
      case 5:
        return AppColors.severityCritical;
      default:
        return AppColors.severityLow;
    }
  }

  Color get _statusColor {
    switch (pothole.status) {
      case 'reported':
        return AppColors.statusReported;
      case 'verified':
        return AppColors.statusVerified;
      case 'in_progress':
        return AppColors.statusInProgress;
      case 'fixed':
        return AppColors.statusFixed;
      case 'rejected':
        return AppColors.statusRejected;
      default:
        return AppColors.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: _severityColor.withValues(alpha: 0.2),
              child: pothole.imageUrl != null
                  ? Image.network(
                      pothole.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.image_not_supported_outlined,
                        size: 32,
                        color: AppColors.onSurfaceVariant.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.report_problem_outlined,
                      size: 32,
                      color: _severityColor,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          pothole.statusLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _statusColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _severityColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          pothole.severityLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _severityColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pothole.address ??
                        '${pothole.latitude.toStringAsFixed(4)}, ${pothole.longitude.toStringAsFixed(4)}',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
