import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTransaction;

  const TransactionItem(
      {Key key, @required this.transaction, @required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: FittedBox(
                  child: Text(
                    "\$${transaction.amount.toStringAsFixed(2)}",
                  ),
                )),
          ),
          title: Text('${transaction.title}'),
          subtitle: Text(
            DateFormat(DateFormat.YEAR_MONTH_DAY).format(transaction.dateTime),
            style: TextStyle(color: Colors.grey),
          ),
          trailing: MediaQuery
              .of(context)
              .size
              .width > 460
              ? TextButton.icon(
              onPressed: deleteTransaction(transaction.id),
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Delete'))
              : IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              deleteTransaction(transaction.id);
            },
          )),
    );
  }
}
