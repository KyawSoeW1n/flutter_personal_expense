import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactionList;
  final Function _deleteTransaction;

  TransactionList(this.transactionList, this._deleteTransaction);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.transactionList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Transaction yet",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * MediaQuery.of(context).textScaleFactor),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return _createTransactionItemWithListTile(
                  widget.transactionList[index]);
            },
            itemCount: widget.transactionList.length);
  }

  Widget _createTransactionItemWithListTile(Transaction transaction) {
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
          trailing: MediaQuery.of(context).size.width > 460
              ? TextButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text('Delete'))
              : IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteTransaction(transaction.id);
                    setState(() {});
                  },
                )),
    );
  }

  void _deleteTransaction(String id) {
    widget._deleteTransaction(id);
  }
}
