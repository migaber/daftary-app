import 'package:expense_repository/expense_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseExpenseRepo implements ExpenseRepository {
  final supabase = Supabase.instance.client;
  final String tableName = 'expenses';

  String? get _userId => supabase.auth.currentUser?.id;

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      final userId = _userId;
      if (userId == null) {
        throw Exception('User must be logged in to create expenses');
      }

      await supabase.from(tableName).insert({
        'expense_id': expense.expenseId,
        'amount': expense.amount,
        'description': expense.description,
        'date': expense.date.toIso8601String(),
        'is_expense': expense.isExpense,
        'user_id': userId,
      });
    } on PostgrestException catch (e) {
      if (e.code == '42501') {
        throw Exception(
          'Permission denied. Please make sure you are logged in and have the necessary permissions.',
        );
      }
      throw Exception('Failed to create expense: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      final userId = _userId;
      if (userId == null) {
        throw Exception('User must be logged in to view expenses');
      }

      final response = await supabase
          .from(tableName)
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false);

      return response.map((data) {
        return Expense(
          expenseId: data['expense_id'] as String,
          amount: (data['amount'] as num).toDouble(),
          description: data['description'] as String,
          date: DateTime.parse(data['date'] as String),
          isExpense: data['is_expense'] as bool,
        );
      }).toList();
    } on PostgrestException catch (e) {
      if (e.code == '42501') {
        throw Exception(
          'Permission denied. Please make sure you are logged in and have the necessary permissions.',
        );
      }
      throw Exception('Failed to fetch expenses: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    try {
      await supabase.from(tableName).delete().eq('expense_id', expenseId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
