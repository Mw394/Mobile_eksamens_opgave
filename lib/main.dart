import 'package:eksamens_opgave/services/account_service.dart';
import 'package:eksamens_opgave/view/account_list.dart';
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
        title: "Accounts",
        theme: ThemeData(primaryColor: Colors.lightBlue),
        home: const AccountList());
  }
}
