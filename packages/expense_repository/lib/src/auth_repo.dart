import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses();
  Future<void> createExpense(Expense expense);
  Future<void> deleteExpense(String expenseId);
}
