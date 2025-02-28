import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
      title: 'Flutter',
      amount: 100.7,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 80.7,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void openAddExpense() {
    //
    showModalBottomSheet(
      backgroundColor: Colors.green,
      context: context,
      builder: (ctx) => NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [IconButton(onPressed: openAddExpense, icon: Icon(Icons.add))],
      ),
      body: Center(
        child: Column(
          children: [
            Text('The Charts'),
            Expanded(child: ExpensesList(expenses: _registeredExpense)),
          ],
        ),
      ),
    );
  }
}
