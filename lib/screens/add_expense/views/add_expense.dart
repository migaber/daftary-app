import 'package:daftary/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:daftary/screens/home/blocs/get_expenses_bloc/get_expenses_bloc_bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descrtionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('d MMM y').format(DateTime.now());
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          context.read<GetExpensesBloc>().add(GetExpenses());
          Navigator.pop(context);
        } else if (state is CreateExpenseLoading) {
          setState(() => isLoading = true);
        } else if (state is CreateExpenseFailure) {
          setState(() => isLoading = false);
          _showErrorDialog(state.error);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Add Expenses",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        CupertinoIcons.money_dollar,
                        size: 60,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: descrtionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      CupertinoIcons.doc_plaintext,
                      size: 32,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now().subtract(Duration(days: 60)),
                      lastDate: DateTime.now(),
                    );

                    if (newDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('d MMM y').format(newDate);
                        selectedDate = newDate;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      CupertinoIcons.calendar,
                      size: 32,
                      color: Colors.grey,
                    ),
                    hintText: "Date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: kToolbarHeight,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (amountController.text.isEmpty) {
                              _showErrorDialog('Please enter an amount');
                              return;
                            }
                            if (descrtionController.text.isEmpty) {
                              _showErrorDialog('Please enter a description');
                              return;
                            }

                            Expense expense = Expense.empty;
                            expense.expenseId = const Uuid().v1();
                            expense.description = descrtionController.text;
                            expense.amount =
                                double.tryParse(amountController.text) ?? 0;
                            expense.date = selectedDate;
                            expense.isExpense = true;
                            context
                                .read<CreateExpenseBloc>()
                                .add(CreateExpense(expense));
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
