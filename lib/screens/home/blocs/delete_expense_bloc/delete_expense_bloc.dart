import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'delete_expense_event.dart';
part 'delete_expense_state.dart';

class DeleteExpenseBloc extends Bloc<DeleteExpenseEvent, DeleteExpenseState> {
  final ExpenseRepository _expenseRepository;

  DeleteExpenseBloc(this._expenseRepository) : super(DeleteExpenseInitial()) {
    on<DeleteExpense>(_onDeleteExpense);
  }

  Future<void> _onDeleteExpense(
    DeleteExpense event,
    Emitter<DeleteExpenseState> emit,
  ) async {
    try {
      emit(DeleteExpenseLoading());
      await _expenseRepository.deleteExpense(event.expenseId);
      emit(DeleteExpenseSuccess());
    } catch (e) {
      emit(DeleteExpenseFailure(e.toString()));
    }
  }
}
