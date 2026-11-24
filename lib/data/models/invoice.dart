import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice {
  final String id;
  final String userId;
  final String? workspaceId;
  final String customerId;
  final String invoiceNumber;
  final double subtotal;
  final double discount;
  final double tax;
  final double total;
  final double paidAmount;
  final double dueAmount;
  final String paymentStatus;
  final DateTime createdAt;

  Invoice({
    String? id,
    required this.userId,
    this.workspaceId,
    required this.customerId,
    required this.invoiceNumber,
    required this.subtotal,
    this.discount = 0.0,
    this.tax = 0.0,
    required this.total,
    this.paidAmount = 0.0,
    this.dueAmount = 0.0,
    this.paymentStatus = 'pending',
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  Invoice copyWith({
    String? id,
    String? userId,
    String? workspaceId,
    String? customerId,
    String? invoiceNumber,
    double? subtotal,
    double? discount,
    double? tax,
    double? total,
    double? paidAmount,
    double? dueAmount,
    String? paymentStatus,
    DateTime? createdAt,
  }) {
    return Invoice(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workspaceId: workspaceId ?? this.workspaceId,
      customerId: customerId ?? this.customerId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

@JsonSerializable()
class InvoiceItem {
  final String id;
  final String invoiceId;
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double total;

  InvoiceItem({
    String? id,
    required this.invoiceId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  }) : id = id ?? const Uuid().v4();

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);
}
