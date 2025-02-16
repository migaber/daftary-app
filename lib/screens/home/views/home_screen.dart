import 'dart:math';

import 'package:daftary/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:daftary/screens/add_expense/views/add_expense.dart';
import 'package:daftary/screens/home/blocs/get_expenses_bloc/get_expenses_bloc_bloc.dart';
import 'package:daftary/screens/home/views/main_screen.dart';
import 'package:daftary/screens/stats/stats.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesBlocState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
            bottomNavigationBar: ClipRRect(
              child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 3.0,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  currentIndex: index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.graph_square_fill),
                      label: "Stats",
                    ),
                  ]),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                            create: (context) =>
                                CreateExpenseBloc(FirebaseExpenseRepo()))
                      ],
                      child: AddExpense(),
                    ),
                  ),
                );
              },
              shape: CircleBorder(),
              child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      transform: const GradientRotation(0.5 * pi),
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                      begin: Alignment.topLeft,
                    ),
                  ),
                  child: Icon(CupertinoIcons.add)),
            ),
            body: index == 0 ? MainScreen(state.expenses) : StatsScreen(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
