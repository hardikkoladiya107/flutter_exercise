
class TransactionData {
  TransactionData({
      List<Transactions>? transactions,}){
    _transactions = transactions;
}

  TransactionData.fromJson(dynamic json) {
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  List<Transactions>? _transactions;
TransactionData copyWith({  List<Transactions>? transactions,
}) => TransactionData(  transactions: transactions ?? _transactions,
);
  List<Transactions>? get transactions => _transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2008-03-05"
/// description : "Temporibus consequatur occaecati"
/// amount : -468.92883558757603
/// fromAccount : "Savings"
/// toAccount : "External"

class Transactions {
  Transactions({
      String? date, 
      String? description, 
      double? amount, 
      String? fromAccount, 
      String? toAccount,}){
    _date = date;
    _description = description;
    _amount = amount;
    _fromAccount = fromAccount;
    _toAccount = toAccount;
}

  Transactions.fromJson(dynamic json) {
    _date = json['date'];
    _description = json['description'];
    _amount = json['amount'];
    _fromAccount = json['fromAccount'];
    _toAccount = json['toAccount'];
  }
  String? _date;
  String? _description;
  double? _amount;
  String? _fromAccount;
  String? _toAccount;
Transactions copyWith({  String? date,
  String? description,
  double? amount,
  String? fromAccount,
  String? toAccount,
}) => Transactions(  date: date ?? _date,
  description: description ?? _description,
  amount: amount ?? _amount,
  fromAccount: fromAccount ?? _fromAccount,
  toAccount: toAccount ?? _toAccount,
);
  String? get date => _date;
  String? get description => _description;
  double? get amount => _amount;
  String? get fromAccount => _fromAccount;
  String? get toAccount => _toAccount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['description'] = _description;
    map['amount'] = _amount;
    map['fromAccount'] = _fromAccount;
    map['toAccount'] = _toAccount;
    return map;
  }

}