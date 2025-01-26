class ExpenseEntity {
  String expenseId;
  double amount;
  String description;
  DateTime date;

  ExpenseEntity({
    required this.expenseId,
    required this.amount,
    required this.description,
    required this.date,
  });

  Map<String, Object?> toDocument() {
    return {
      'amount': amount,
      'description': description,
      'date': date,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      amount: doc['amount'],
      description: doc['description'],
      date: doc['date'],
      expenseId: doc['expenseId'],
    );
  }
}
