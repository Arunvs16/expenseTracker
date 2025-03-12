import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key,
   required this.expenses,
   required this.onRemoveExpense,
   });
  final Function(Expense) onRemoveExpense;
  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (context, index) => Dismissible(
            onDismissed: (direction)=>onRemoveExpense(expenses[index]),
            key: ValueKey(expenses[index]),
            child: ExpensesItem(expenses[index]),
          ),
    );
  }
}
