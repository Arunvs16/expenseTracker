import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
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
            decoration: InputDecoration(label: Text('Title')),
          ),

          // amount
          TextField(
            controller: _amountController,
            maxLength: 6,
            keyboardType: TextInputType.number,

            decoration: InputDecoration(prefixText: '₹', label: Text('Amount')),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // cancel button
              TextButton(
                onPressed: () {
                  print('Cancel button pressed');
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              // submit button
              ElevatedButton(
                onPressed: () {
                  print('Entered --------->  ${_titleController.text}');
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
