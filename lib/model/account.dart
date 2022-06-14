import 'package:eksamens_opgave/model/accountTypes.dart';

class Account {
  String name;
  late AccountTypes accountType;
  late String iban;

  Account(this.name) {
    iban = "";
  }

  Account.fromJSON(Map<String, dynamic> json, String snapShotID)
      : name = json["name"],
        accountType = AccountTypes.values.byName(json["accountType"]),
        iban = snapShotID;

  Map<String, dynamic> toJSON() {
    return {
      "accountType": accountType.name,
      "name": name,
      "iban": iban,
    };
  }
}
