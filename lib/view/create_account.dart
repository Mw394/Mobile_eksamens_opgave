import 'package:eksamens_opgave/model/account.dart';
import 'package:eksamens_opgave/model/accountTypes.dart';
import 'package:eksamens_opgave/services/account_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({Key? key}) : super(key: key);

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final Account account = Account("");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Account"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<AccountTypes>(
                  decoration:
                      const InputDecoration(hintText: "Choose account type"),
                  items: AccountTypes.values.map((AccountTypes accountType) {
                    return DropdownMenuItem<AccountTypes>(
                        value: accountType,
                        child: Row(
                          children: <Widget>[
                            Text(accountType.name),
                          ],
                        ));
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => account.accountType = value!),
                  validator: (value) {
                    if (value == null) {
                      return "Please select account type";
                    }
                    return null;
                  }),
              TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  onSaved: (value) => setState(() => account.name = value!),
                  validator: (value) {
                    return validateEmpty(value, "Name");
                  }),
              ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      Provider.of<AccountService>(context, listen: false)
                          .add(account);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Create"))
            ],
          )),
    );
  }
}

validateEmpty(dynamic value, String textFieldName) {
  if (value.isEmpty || value == null) {
    return 'Enter text in ' + textFieldName;
  }
  return null;
}
