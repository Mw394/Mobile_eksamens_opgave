import 'package:eksamens_opgave/model/account.dart';
import 'package:eksamens_opgave/model/transaction.dart';
import 'package:eksamens_opgave/services/account_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateTransactionForm extends StatefulWidget {
  final Account account;
  const CreateTransactionForm({Key? key, required this.account})
      : super(key: key);

  @override
  State<CreateTransactionForm> createState() =>
      // ignore: no_logic_in_create_state
      _CreateTransactionFormState(account: account);
}

class _CreateTransactionFormState extends State<CreateTransactionForm> {
  Account account;
  late AccountTransaction transaction;
  _CreateTransactionFormState({required this.account}) {
    transaction = AccountTransaction(0.0, "", account);
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Transaction"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Beneficiary", hintText: "Beneficiary"),
                  onChanged: (value) =>
                      setState(() => transaction.beneficiary = value),
                  validator: (value) {
                    return validateEmpty(value, "Beneficiary");
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Amount", hintText: "Kr. 0.0"),
                  onChanged: (value) => setState(() =>
                      transaction.amount = double.parse(value.toString())),
                  validator: (value) {
                    return validateEmpty(value, "Amount");
                  }),
              ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      var transactionOk =
                          Provider.of<AccountService>(context, listen: false)
                              .transactionOk(account, transaction);
                      form.save();
                      if (transactionOk) {
                        Provider.of<AccountService>(context, listen: false)
                            .addTransaction(transaction);
                        Navigator.pop(context);
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => const AlertDialog(
                                  title: Text("Cannot complete transaction."),
                                  content: Text(
                                      "Cannot withdraw money due to insuffienct funds"),
                                ));
                      }
                    }
                  },
                  child: const Text("Create"))
            ],
          )),
    );
  }
}

validateEmpty(dynamic value, String textFieldName) {
  if (value.isEmpty) {
    return 'Please specify $textFieldName';
  }
  return null;
}
