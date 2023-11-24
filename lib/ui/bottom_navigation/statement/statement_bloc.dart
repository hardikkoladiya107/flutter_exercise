import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'statement_event.dart';
part 'statement_state.dart';

class StatementBloc extends Bloc<StatementEvent, StatementState> {

  StatementBloc() : super(StatementInitial()) {
    on<StatementEvent>((event, emit) {
      if(event is InitialEvent){
        emit(StatementInitial());
      }else if(event is DropdownSelectionEvent){
        emit(selectDropdownItem(event.value));
      }
    });
  }

  //String selectedDropDownItem = "Select Year";

  var dropDownList = ['Select Year','2019', '2020', '2021', '2022', '2023'];

  StatementState selectDropdownItem(String value) {
    return StatementInitial(value: value);
  }
}
