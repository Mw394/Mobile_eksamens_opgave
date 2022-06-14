import 'package:cloud_firestore/cloud_firestore.dart';

import 'account.dart';

class AccountTransaction {
  double amount;
  DateTime creationDate;
  String beneficiary;
  Account account;

  AccountTransaction(this.amount, this.beneficiary, this.account)
      : creationDate = DateTime.now();

  AccountTransaction.fromJSON(Map<String, dynamic> json, String snapShotID)
      : amount = json["amount"],
        account = Account.fromJSON(json["account"], json["account"]["iban"]),
        creationDate = DateTime.parse(json["creationDate"]),
        beneficiary = json["beneficiary"];

  Map<String, dynamic> toJSON() {
    return {
      "account": account.toJSON(),
      "amount": amount,
      "creationDate": creationDate.toIso8601String(),
      "beneficiary": beneficiary
    };
  }
}
