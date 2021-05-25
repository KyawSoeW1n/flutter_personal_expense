import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/model/Transaction.dart';
import 'package:flutter_personal_expense/widgets/chart_bar_widget.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekDay.day &&
            recentTransaction[i].dateTime.month == weekDay.month &&
            recentTransaction[i].dateTime.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                  _totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / _totalSpending,
                ),
              );
            }).toList(),
          ),
        ));
  }

  double get _totalSpending {
    return widget.groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }
}
