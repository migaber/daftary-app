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
      'expense_id': expenseId,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'is_expense': isExpense,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expense_id'] as String,
      amount: (doc['amount'] as num).toDouble(),
      description: doc['description'] as String,
      date: DateTime.parse(doc['date'] as String),
      isExpense: doc['is_expense'] as bool,
    );
  }
}
