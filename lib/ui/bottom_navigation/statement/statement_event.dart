part of 'statement_bloc.dart';

@immutable
abstract class StatementEvent {}


class InitialEvent extends StatementEvent{}

class DropdownSelectionEvent extends StatementEvent{
  String value;
  DropdownSelectionEvent({this.value = "Select Year"});
}