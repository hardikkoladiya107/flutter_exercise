

class AccountData {
  AccountData({
      List<Accounts>? accounts,}){
    _accounts = accounts;
}

  AccountData.fromJson(dynamic json) {
    if (json['accounts'] != null) {
      _accounts = [];
      json['accounts'].forEach((v) {
        _accounts?.add(Accounts.fromJson(v));
      });
    }
  }
  List<Accounts>? _accounts;
AccountData copyWith({  List<Accounts>? accounts,
}) => AccountData(  accounts: accounts ?? _accounts,
);
  List<Accounts>? get accounts => _accounts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_accounts != null) {
      map['accounts'] = _accounts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "985c1db8-a123-419b-9c2f-18698092cccf"
/// accountNumber : "8767908203"
/// accountType : "Checking"
/// balance : 4606.73
/// accountHolder : "Marta Maggio"

class Accounts {
  Accounts({
      String? id, 
      String? accountNumber, 
      String? accountType, 
      double? balance, 
      String? accountHolder,}){
    _id = id;
    _accountNumber = accountNumber;
    _accountType = accountType;
    _balance = balance;
    _accountHolder = accountHolder;
}

  Accounts.fromJson(dynamic json) {
    _id = json['id'];
    _accountNumber = json['accountNumber'];
    _accountType = json['accountType'];
    _balance = json['balance'];
    _accountHolder = json['accountHolder'];
  }
  String? _id;
  String? _accountNumber;
  String? _accountType;
  double? _balance;
  String? _accountHolder;
Accounts copyWith({  String? id,
  String? accountNumber,
  String? accountType,
  double? balance,
  String? accountHolder,
}) => Accounts(  id: id ?? _id,
  accountNumber: accountNumber ?? _accountNumber,
  accountType: accountType ?? _accountType,
  balance: balance ?? _balance,
  accountHolder: accountHolder ?? _accountHolder,
);
  String? get id => _id;
  String? get accountNumber => _accountNumber;
  String? get accountType => _accountType;
  double? get balance => _balance;
  String? get accountHolder => _accountHolder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['accountNumber'] = _accountNumber;
    map['accountType'] = _accountType;
    map['balance'] = _balance;
    map['accountHolder'] = _accountHolder;
    return map;
  }

}