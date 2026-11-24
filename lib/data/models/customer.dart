import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'customer.g.dart';

@JsonSerializable()
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
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

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
