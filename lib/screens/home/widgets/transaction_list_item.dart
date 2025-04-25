import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daftary/screens/home/blocs/delete_expense_bloc/delete_expense_bloc.dart';
import 'package:daftary/screens/home/blocs/get_expenses_bloc/get_expenses_bloc_bloc.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    super.key,
    required this.transaction,
  });

  final Expense transaction;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteExpenseBloc, DeleteExpenseState>(
      listener: (context, state) {
        if (state is DeleteExpenseSuccess) {
          context.read<GetExpensesBloc>().add(GetExpenses());
        }
      },
      child: Dismissible(
        key: Key(transaction.expenseId),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          color: Colors.red,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          final deleteConfirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete Expense'),
              content: Text('Are you sure you want to delete this expense?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );

          if (deleteConfirmed ?? false) {
            context
                .read<DeleteExpenseBloc>()
                .add(DeleteExpense(transaction.expenseId));
          }
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            transaction.isExpense
                                ? CupertinoIcons.minus_circle_fill
                                : CupertinoIcons.add_circled_solid,
                            color: transaction.isExpense
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.primary,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        transaction.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${transaction.isExpense ? '-' : ''}${transaction.amount} LE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(
                          transaction.date,
                        ),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
