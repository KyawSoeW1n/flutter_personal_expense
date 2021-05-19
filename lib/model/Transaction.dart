import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;

  Transaction(this.id, this.title, this.amount,
      this.dateTime);
}
