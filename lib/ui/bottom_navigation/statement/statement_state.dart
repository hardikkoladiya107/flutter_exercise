part of 'statement_bloc.dart';

@immutable
  class StatementState {
  String value;
  StatementState({required this.value});
}

class StatementInitial extends StatementState {
  StatementInitial({String value ="Select Year"}):super(value: value);
}
