import 'package:eksamens_opgave/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

class TransactionRow extends StatelessWidget {
  final AccountTransaction transaction;
  const TransactionRow({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(transaction.beneficiary),
        subtitle: Text(DateFormat.yMMMMd('en_US')
            .format(transaction.creationDate)
            .toString()),
        trailing: Text(
          NumberFormat.currency(
                  locale: "da", symbol: "Kr.", customPattern: '\u00a4 #,###.##')
              .format(transaction.amount),
        ));
  }
}
