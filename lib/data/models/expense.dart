import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final String userId;
  final String? workspaceId;
  final String category;
  final double amount;
  final String? description;
  final DateTime createdAt;

  Expense({
    String? id,
    required this.userId,
    this.workspaceId,
    required this.category,
    required this.amount,
    this.description,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      workspaceId: json['workspace_id'] as String?,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'workspace_id': workspaceId,
      'category': category,
      'amount': amount,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Expense copyWith({
    String? id,
    String? userId,
    String? workspaceId,
    String? category,
    double? amount,
    String? description,
    DateTime? createdAt,
  }) {
    return Expense(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workspaceId: workspaceId ?? this.workspaceId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

const List<String> expenseCategories = [
  'Rent',
  'Electricity',
  'Transport',
  'Salary',
  'Purchase',
  'Marketing',
  'Other',
];
