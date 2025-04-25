import 'package:daftary/screens/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:daftary/screens/home/blocs/get_expenses_bloc/get_expenses_bloc_bloc.dart';
import 'package:daftary/screens/home/views/home_screen.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daftry",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: Color(0xFF009AE7),
          secondary: Color(0xffe064f7),
          tertiary: Color(0xffff8d6c),
          outline: Colors.grey.shade500,
        ),
      ),
      home: BlocProvider(
        create: (context) =>
            GetExpensesBloc(SupabaseExpenseRepo())..add(GetExpenses()),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Daftary'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
            ],
          ),
          body: HomeScreen(),
        ),
      ),
    );
  }
}
