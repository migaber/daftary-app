import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseEntity {
  String expenseId;
  double amount;
  String description;
  DateTime date;
  bool isExpense;

  ExpenseEntity({
    required this.expenseId,
    required this.amount,
    required this.description,
    required this.date,
    required this.isExpense,
  });

  Map<String, Object?> toDocument() {
    return {
      'expenseId': expenseId,
      'amount': amount,
      'description': description,
      'date': date,
      'isExpense': isExpense,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'],
      amount: doc['amount'],
      description: doc['description'],
      date: (doc['date'] as Timestamp).toDate(),
      isExpense: doc['isExpense'],
    );
  }
}
