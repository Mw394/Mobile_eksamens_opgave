import 'dart:js';

import 'package:eksamens_opgave/model/transactionRouteArugments.dart';
import 'package:eksamens_opgave/services/account_service.dart';
import 'package:eksamens_opgave/view/account_list.dart';
import 'package:eksamens_opgave/view/create_account.dart';
import 'package:eksamens_opgave/view/create_account_transaction.dart';
import 'package:eksamens_opgave/view/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AccountService(),
    child: const Accounts(),
  ));
}

class Accounts extends StatelessWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "/",
        onGenerateRoute: generateRoute,
        //routes: {
        //"/": ((context) => const AccountList()),
        //"/transactions": (context) => const TransactionList(account: null),
        //"/newAccount": (context) => const CreateAccountForm(),
        //"/newTransaction": (context) => const CreateTransactionForm(account: null)
        //},
        title: "Accounts",
        theme: ThemeData(primaryColor: Colors.lightBlue));
    //home: const AccountList());
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (context) => const AccountList());
    case "/newAccount":
      return MaterialPageRoute(builder: (context) => const CreateAccountForm());
    case "/transactions":
      var data = settings.arguments as TransactionRouteArguments;
      return MaterialPageRoute(
          builder: (context) => TransactionList(account: data.account));
    case "/newTransaction":
      var data = settings.arguments as TransactionRouteArguments;
      return MaterialPageRoute(
          builder: (context) => CreateTransactionForm(account: data.account));
    default:
      return MaterialPageRoute(builder: (context) => const AccountList());
  }
}
