

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_exercise/ui/bottom_navigation/statement/statement_bloc.dart';
 import 'package:flutter_test/flutter_test.dart';

void main(){
  group('Statement Bloc Testing', () {
    late StatementBloc statementBloc;

    setUp(() {
      statementBloc = StatementBloc();
    });

    blocTest(
      'Checking by passing initial event and getting initial state',
      build: () => statementBloc,
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [
        isA<StatementInitial>(),
      ],
    );

    blocTest(
      'Checking by passing initial event and getting initial state',
      build: () => statementBloc,
      act: (bloc){
        bloc.add(DropdownSelectionEvent()..value="Testing");
      },
      expect: () => [
        isA<StatementInitial>().having((p) => p.value, "description", "Testing"),
      ],
    );

    tearDown(() {
      statementBloc.close();
    });
  });
}