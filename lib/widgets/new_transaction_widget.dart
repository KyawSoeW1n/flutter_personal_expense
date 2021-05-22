import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/widgets/common_widget/adaptive_flat_button_widget.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                _submitData();
              },
            ),
            Row(
              children: [
                Text(_selectedDate == null
                    ? 'No Date Chosen'
                    : DateFormat(DateFormat.YEAR_MONTH_DAY)
                        .format(_selectedDate)),
                TextButton(
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _showDatePicker();
                  },
                ),
              ],
            ),
            AdaptiveFlatButton(_submitData, 'Add')
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    _selectedDate = null;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) => {
              if (value == null)
                {print("Choose Date")}
              else
                {_selectedDate = value}
            });

    setState(() {});
  }

  void _submitData() {
    final enterTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);
    if (enterTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);
  }
}
