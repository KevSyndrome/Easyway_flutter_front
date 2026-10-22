import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String username;
  final String? fullName;
  final String status;
  final bool isSuperuser;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    required this.username,
    this.fullName,
    required this.status,
    required this.isSuperuser,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String?,
      status: json['status'] as String,
      isSuperuser: json['is_superuser'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'full_name': fullName,
      'status': status,
      'is_superuser': isSuperuser,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    fullName,
    status,
    isSuperuser,
    createdAt,
  ];
}
