import 'package:eksamens_opgave/services/account_service.dart';
import 'package:eksamens_opgave/view/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';

class AccountRow extends StatelessWidget {
  final Account account;
  final double balance;
  const AccountRow({Key? key, required this.account, required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(account.name + " | " + account.accountType.name),
      subtitle: Text("Iban: " + account.iban),
      trailing: Text(NumberFormat.currency(
              locale: "da", symbol: "Kr.", customPattern: '\u00a4 #,###.##')
          .format(balance)),
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionList(
                      account: account,
                    )))
      },
    );
  }
}
