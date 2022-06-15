import 'package:eksamens_opgave/model/account.dart';
import 'package:eksamens_opgave/model/transaction.dart';
import 'package:eksamens_opgave/model/transactionRouteArugments.dart';
import 'package:eksamens_opgave/services/account_service.dart';
import 'package:eksamens_opgave/view/create_account_transaction.dart';
import 'package:eksamens_opgave/view/transaction_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatefulWidget {
  final Account account;
  const TransactionList({Key? key, required this.account}) : super(key: key);

  @override
  State<TransactionList> createState() =>
      // ignore: no_logic_in_create_state
      _TransactionListState(account: account);
}

class _TransactionListState extends State<TransactionList> {
  Account account;
  _TransactionListState({required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        actions: <Widget>[
          FloatingActionButton.extended(
              label: const Text("New Transaction"),
              onPressed: () async => {
                    Navigator.pushNamed(context, "/newTransaction",
                        arguments: TransactionRouteArguments(account: account))
                    /*
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateTransactionForm(
                                  account: account,
                                )))*/
                  })
        ],
      ),
      body:
          Consumer<AccountService>(builder: (context, _accountService, widget) {
        return ListView.builder(
            itemCount: _accountService.transactionList(account).length,
            itemBuilder: (context, index) {
              if (_accountService.transactionList(account).isNotEmpty) {
                final AccountTransaction transaction =
                    _accountService.transactionList(account)[index];
                return TransactionRow(transaction: transaction);
              } else {
                return Container();
              }
            });
      }),
    );
  }
}
