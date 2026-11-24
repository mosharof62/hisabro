import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String userId;
  final String? workspaceId;
  final String name;
  final String? category;
  final double buyPrice;
  final double sellPrice;
  final int stock;
  final int lowStockLimit;
  final String? barcode;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    String? id,
    required this.userId,
    this.workspaceId,
    required this.name,
    this.category,
    required this.buyPrice,
    required this.sellPrice,
    this.stock = 0,
    this.lowStockLimit = 5,
    this.barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? userId,
    String? workspaceId,
    String? name,
    String? category,
    double? buyPrice,
    double? sellPrice,
    int? stock,
    int? lowStockLimit,
    String? barcode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workspaceId: workspaceId ?? this.workspaceId,
      name: name ?? this.name,
      category: category ?? this.category,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      stock: stock ?? this.stock,
      lowStockLimit: lowStockLimit ?? this.lowStockLimit,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  bool get isLowStock => stock <= lowStockLimit;
  double get stockValue => stock * buyPrice;
  double get profitMargin => sellPrice - buyPrice;
}
