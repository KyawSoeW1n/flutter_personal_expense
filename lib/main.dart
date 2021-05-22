import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/model/Transaction.dart';
import 'package:flutter_personal_expense/widgets/chart_widget.dart';
import 'package:flutter_personal_expense/widgets/new_transaction_widget.dart';
import 'package:flutter_personal_expense/widgets/transaction_list_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ' Personal Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionList = [];
  bool _isShowChart = false;

  List<Transaction> get _recentTransaction {
    return _transactionList.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTransaction =
        Transaction(DateTime.now().toString(), title, amount, selectedDate);
    _transactionList.add(newTransaction);
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              widget.title,
            ),
            trailing: CupertinoButton(
              child: Icon(
                CupertinoIcons.add,
                color: Colors.black,
              ),
              onPressed: () {
                _showBottomSheetForNewTransaction(context);
              },
              padding: EdgeInsets.zero,
            ),
          )
        : AppBar(title: Text(widget.title), actions: [
            if (Platform.isIOS)
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showBottomSheetForNewTransaction(context);
                  })
          ]);

    final transactionWidget = Container(
        margin: EdgeInsets.all(4.0),
        height: mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top * 0.7,
        child: TransactionList(_transactionList, _deleteTransaction));

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart",
                    style: Theme.of(context).textTheme.headline6),
                Switch.adaptive(
                  value: _isShowChart,
                  onChanged: (value) {
                    setState(() {
                      _isShowChart = value;
                    });
                  },
                  activeColor: Colors.deepPurple,
                ),
              ],
            ),
          if (_isLandscape)
            _isShowChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransaction))
                : Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.75,
                    child:
                        TransactionList(_transactionList, _deleteTransaction)),
          if (!_isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransaction)),
          if (!_isLandscape) transactionWidget,
        ],
      ),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(child: pageBody, navigationBar: appBar)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _showBottomSheetForNewTransaction(context);
                    },
                  ),
          );
  }

  void _showBottomSheetForNewTransaction(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((tx) => tx.id == id);
    });
  }
}
