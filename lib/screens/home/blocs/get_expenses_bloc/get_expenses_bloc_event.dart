part of 'get_expenses_bloc_bloc.dart';

sealed class GetExpensesBlocEvent extends Equatable {
  const GetExpensesBlocEvent();

  @override
  List<Object> get props => [];
}

class GetExpenses extends GetExpensesBlocEvent {}
