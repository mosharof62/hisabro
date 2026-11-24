import 'package:uuid/uuid.dart';

class Customer {
  final String id;
  final String userId;
  final String? workspaceId;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final double openingBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer({
    String? id,
    required this.userId,
    this.workspaceId,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.openingBalance = 0.0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      workspaceId: json['workspace_id'] as String?,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      openingBalance: (json['opening_balance'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'workspace_id': workspaceId,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'opening_balance': openingBalance,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Customer copyWith({
    String? id,
    String? userId,
    String? workspaceId,
    String? name,
    String? phone,
    String? email,
    String? address,
    double? openingBalance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      openingBalance: openingBalance ?? this.openingBalance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
