import 'package:daftary/screens/home/widgets/home_page_creditcard.dart';
import 'package:daftary/screens/home/widgets/transaction_list_item.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  const MainScreen(this.expenses, {super.key});

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
            child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, int i) {
                  final transaction = expenses[i];
                  return TransactionListItem(transaction: transaction);
                }),
          )
        ]),
      ),
    );
  }
}
