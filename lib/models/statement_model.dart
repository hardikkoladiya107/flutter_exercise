
class StatementData {
  StatementData({
      List<Statements>? statements,}){
    _statements = statements;
}

  StatementData.fromJson(dynamic json) {
    if (json['statements'] != null) {
      _statements = [];
      json['statements'].forEach((v) {
        _statements?.add(Statements.fromJson(v));
      });
    }
  }
  List<Statements>? _statements;
StatementData copyWith({  List<Statements>? statements,
}) => StatementData(  statements: statements ?? _statements,
);
  List<Statements>? get statements => _statements;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_statements != null) {
      map['statements'] = _statements?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2023-11-18"
/// description : "Non sequi sequi est ea provident error eaque architecto."
/// amount : -57136.519718915224

class Statements {
  Statements({
      String? date, 
      String? description, 
      double? amount,}){
    _date = date;
    _description = description;
    _amount = amount;
}

  Statements.fromJson(dynamic json) {
    _date = json['date'];
    _description = json['description'];
    _amount = json['amount'];
  }
  String? _date;
  String? _description;
  double? _amount;
Statements copyWith({  String? date,
  String? description,
  double? amount,
}) => Statements(  date: date ?? _date,
  description: description ?? _description,
  amount: amount ?? _amount,
);
  String? get date => _date;
  String? get description => _description;
  double? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['description'] = _description;
    map['amount'] = _amount;
    return map;
  }

}