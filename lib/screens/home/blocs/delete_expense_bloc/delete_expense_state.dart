part of 'delete_expense_bloc.dart';

abstract class DeleteExpenseState extends Equatable {
  const DeleteExpenseState();

  @override
  List<Object> get props => [];
}

class DeleteExpenseInitial extends DeleteExpenseState {}

class DeleteExpenseLoading extends DeleteExpenseState {}

class DeleteExpenseSuccess extends DeleteExpenseState {}

class DeleteExpenseFailure extends DeleteExpenseState {
  final String error;

  const DeleteExpenseFailure(this.error);

  @override
  List<Object> get props => [error];
}
