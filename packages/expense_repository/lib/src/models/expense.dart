import '../entities/entities.dart';

class Expense {
  String expenseId;
  double amount;
  String description;
  DateTime date;

  Expense({
    required this.expenseId,
    required this.amount,
    required this.description,
    required this.date,
  });

  static final empty = Expense(
    expenseId: '',
    amount: 0,
    description: '',
    date: DateTime.now(),
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      amount: amount,
      description: description,
      date: date,
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      amount: entity.amount,
      description: entity.description,
      date: entity.date,
    );
  }
}
