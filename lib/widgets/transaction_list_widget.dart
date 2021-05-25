import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/model/Transaction.dart';
import 'package:flutter_personal_expense/widgets/transaction_item_widget.dart';

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
                Text("No Transaction yet",
                    style: Theme.of(context).textTheme.headline6),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: widget.transactionList[index],
                  deleteTransaction: _deleteTransaction);
              // return _createTransactionItemWithListTile(
              //     widget.transactionList[index]);
            },
            itemCount: widget.transactionList.length);
  }

  void _deleteTransaction(String id) {
    widget._deleteTransaction(id);
  }
}
