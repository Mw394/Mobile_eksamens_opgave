import 'package:eksamens_opgave/services/account_service.dart';
import 'package:eksamens_opgave/view/account_row.dart';
import 'package:eksamens_opgave/view/create_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts"),
        actions: <Widget>[
          FloatingActionButton.extended(
              label: const Text("New account"),
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccountForm()))
                  })
        ],
      ),
      body:
          Consumer<AccountService>(builder: (context, _accountService, widget) {
        return ListView.builder(
            itemCount: _accountService.numberOfAccounts,
            itemBuilder: (context, index) {
              final Account account = _accountService.accountList[index];
              var balance = _accountService.balance(account);
              return AccountRow(account: account, balance: balance);
            });
      }),
    );
  }
}
