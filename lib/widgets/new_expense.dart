// ignore_for_file: avoid_print

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final Function(Expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // controllers
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // variable to store selected category
  Category _selectedCategory = Category.leisure;

  DateTime? selectedDate;

  // date picker
  void datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
      print('selected date ------ > $pickedDate');
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // tryParse('Hello') => null, tryParse('123') => 123
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      // show error meassage
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text(
              'Please make sure a valid title, amount, date and category was entered.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    }

    widget.onAddExpense(
      Expense(
        amount: enteredAmount!,
        date: selectedDate!,
        title: _titleController.text,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // title
          TextField(
            controller: _titleController,
            maxLength: 40,
            decoration: InputDecoration(label: const Text('Title')),
          ),
          Row(
            children: [
              // amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '₹',
                    label: const Text('Amount'),
                  ),
                ),
              ),
              //spacing
              const SizedBox(width: 16),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // selected date
                    GestureDetector(
                      onTap: datePicker,
                      child: Text(
                        selectedDate == null
                            ? 'Select Date'
                            : dateFormatter.format(selectedDate!),
                      ),
                    ),

                    // date picker
                    IconButton(
                      onPressed: datePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // DropdownButton
              DropdownButton(
                value: _selectedCategory,
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              // cancel button
              TextButton(
                onPressed: () {
                  print('Cancel button pressed');
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              // submit button
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                  print('Title --------->  ${_titleController.text}');
                  print('Amount --------->  ${_amountController.text}');
                  print('Date --------->  $selectedDate');
                  print('Save pressed --------->  ${_amountController.text}');
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
