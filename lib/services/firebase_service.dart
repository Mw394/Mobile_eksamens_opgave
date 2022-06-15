import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/account.dart';
import '../model/transaction.dart';

class FirebaseService {
  var accountRef = FirebaseFirestore.instance
      .collection("Accounts")
      .withConverter<Account>(
          fromFirestore: (snapshot, _) =>
              Account.fromJSON(snapshot.data()!, snapshot.id),
          toFirestore: (item, _) => item.toJSON());

  var transactionsRef = FirebaseFirestore.instance
      .collection("Transactions")
      .withConverter<AccountTransaction>(
          fromFirestore: (snapshot, _) =>
              AccountTransaction.fromJSON(snapshot.data()!, snapshot.id),
          toFirestore: (item, _) => item.toJSON());

  addAccount(Account account) async {
    await accountRef.add(account);
  }

  addTransaction(AccountTransaction transaction) async {
    await transactionsRef.add(transaction);
  }

  removeAccount(Account account) async {
    await accountRef
        .doc(account.iban)
        .delete()
        .then((value) => print("Account deleted"))
        .catchError((error) => print("Failed to delete account: $error"));
  }

  updateAccount(Account account, String newAccountName) async {
    await accountRef
        .doc(account.iban)
        .update({"name": newAccountName}).then((_) => print("Updated"));
  }

  printWhatsChanged() {
    FirebaseFirestore.instance
        .collection("Accounts")
        .snapshots()
        .listen((result) {
      result.docChanges.forEach((element) {
        var documentType = element.type;
        if (documentType == DocumentChangeType.added) {
          print("Object added");
          print(element.doc.data());
        } else if (documentType == DocumentChangeType.modified) {
          print("Object modified");
          print(element.doc.data());
        } else if (documentType == DocumentChangeType.removed) {
          print("Object removed");
          print(element.doc.data());
        }
      });
    });
  }
}
