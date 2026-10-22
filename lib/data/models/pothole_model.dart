import 'package:equatable/equatable.dart';

class Pothole extends Equatable {
  final int id;
  final int reporterId;
  final double latitude;
  final double longitude;
  final String? address;
  final int severity;
  final String status;
  final String? description;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Pothole({
    required this.id,
    required this.reporterId,
    required this.latitude,
    required this.longitude,
    this.address,
    required this.severity,
    required this.status,
    this.description,
    this.imageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory Pothole.fromJson(Map<String, dynamic> json) {
    return Pothole(
      id: json['id'] as int,
      reporterId: json['reporter_id'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      severity: json['severity'] as int? ?? 1,
      status: json['status'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  String get severityLabel {
    switch (severity) {
      case 1:
        return 'Leve';
      case 2:
        return 'Moderado';
      case 3:
        return 'Grave';
      case 4:
      case 5:
        return 'Crítico';
      default:
        return 'Desconocido';
    }
  }

  String get statusLabel {
    switch (status) {
      case 'reported':
        return 'Reportado';
      case 'verified':
        return 'Verificado';
      case 'in_progress':
        return 'En proceso';
      case 'fixed':
        return 'Arreglado';
      case 'rejected':
        return 'Rechazado';
      default:
        return 'Desconocido';
    }
  }

  @override
  List<Object?> get props => [
    id,
    reporterId,
    latitude,
    longitude,
    address,
    severity,
    status,
    description,
    imageUrl,
    createdAt,
    updatedAt,
  ];
}
