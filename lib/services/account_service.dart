import 'package:eksamens_opgave/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';

import '../model/account.dart';
import '../model/transaction.dart';

class AccountService extends ChangeNotifier {
  List<Account> _accounts = [];
  List<AccountTransaction> _transactions = [];

  final _dbRef = FirebaseService().accountRef;
  final _dbRefTransactions = FirebaseService().transactionsRef;

  AccountService() {
    _dbRef.snapshots().listen((documents) {
      _accounts.clear();
      for (var doc in documents.docs) {
        _accounts.add(doc.data());
      }
      notifyListeners();
    });
    _dbRefTransactions.snapshots().listen((documents) {
      _transactions.clear();
      for (var doc in documents.docs) {
        _transactions.add(doc.data());
      }
      notifyListeners();
    });
  }

  add(Account account) async {
    await _dbRef.add(account);
  }

  List<Account> get accountList {
    return _accounts;
  }

  int get numberOfAccounts {
    return _accounts.length;
  }

  addTransaction(AccountTransaction transaction) async {
    await _dbRefTransactions.add(transaction);
  }

  List<AccountTransaction> transactionList(Account account) {
    List<AccountTransaction> returnList = [];
    for (var item in _transactions) {
      if (item.account.iban == account.iban) {
        returnList.add(item);
      }
    }
    returnList.sort(((a, b) {
      return b.creationDate.compareTo(a.creationDate);
    }));
    return returnList;
  }

  double balance(Account account) {
    double balance = 0;
    for (var transaction in _transactions) {
      if (transaction.account.iban == account.iban) {
        balance += transaction.amount;
      }
    }
    return balance;
  }

  bool transactionOk(Account account, AccountTransaction transaction) {
    bool transactionOk = true;
    var currentBalance = balance(account);
    currentBalance += transaction.amount;
    if (currentBalance < 0) {
      transactionOk = false;
    }
    return transactionOk;
  }
}
