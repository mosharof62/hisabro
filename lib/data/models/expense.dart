import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'expense.g.dart';

@JsonSerializable()
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
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);

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
