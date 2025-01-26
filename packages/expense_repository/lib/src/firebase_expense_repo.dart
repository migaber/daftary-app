import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final expenseCollection = FirebaseFirestore.instance.collection("expnses");
  @override
  Future<void> createExpense(Expense expense) async {
    final expenseCollection = FirebaseFirestore.instance.collection('expenses');
    try {
      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toEntity().toDocument());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpense() async {
    try {
      return await expenseCollection.get().then((value) => value.docs
          .map((e) => Expense.fromEntity(ExpenseEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      rethrow;
    }
  }
}
