import 'package:expense_repository/src/models/expense.dart';

abstract class ExpenseRepository {
  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getExpenses();
}
