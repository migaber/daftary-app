import 'package:daftary/screens/home/widgets/home_page_creditcard.dart';
import 'package:daftary/screens/home/widgets/transaction_list_item.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:daftary/screens/home/blocs/get_expenses_bloc/get_expenses_bloc_bloc.dart';
import 'package:daftary/screens/home/blocs/delete_expense_bloc/delete_expense_bloc.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  final ExpenseRepository expenseRepo;

  const MainScreen(this.expenses, {required this.expenseRepo, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.person_fill,
                        color: Colors.yellow.shade800,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      Text("Mohamed Gaber",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.settings),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          HomePageCreditcard(),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (expenses.isNotEmpty)
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<GetExpensesBloc>(),
                ),
                BlocProvider(
                  create: (context) => DeleteExpenseBloc(expenseRepo),
                ),
              ],
              child: expenses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.money_dollar_circle,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No expenses yet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Add your first expense by tapping the + button",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, int i) {
                        final transaction = expenses[i];
                        return TransactionListItem(transaction: transaction);
                      }),
            ),
          )
        ]),
      ),
    );
  }
}
