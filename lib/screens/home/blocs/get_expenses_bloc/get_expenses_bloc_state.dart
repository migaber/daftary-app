part of 'get_expenses_bloc_bloc.dart';

sealed class GetExpensesBlocState extends Equatable {
  const GetExpensesBlocState();

  @override
  List<Object> get props => [];
}

final class GetExpensesInitial extends GetExpensesBlocState {}

final class GetExpensesLoading extends GetExpensesBlocState {}

final class GetExpensesFailure extends GetExpensesBlocState {}

final class GetExpensesSuccess extends GetExpensesBlocState {
  final List<Expense> expenses;

  const GetExpensesSuccess(this.expenses);

  @override
  List<Object> get props => [expenses];
}
