import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/model/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactionList;

  TransactionList(this.transactionList);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: widget.transactionList.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("No Transaction yet"),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return _createTransactionItemWithListTile(
                    widget.transactionList[index]);
              },
              itemCount: widget.transactionList.length),
    );
  }

  Widget _createTransactionItemWithListTile(Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              widget.transactionList.remove(transaction);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
