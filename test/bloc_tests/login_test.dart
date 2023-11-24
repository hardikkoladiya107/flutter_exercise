
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_exercise/ui/login/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login Bloc Testing', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = LoginBloc();
    });

    blocTest(
      'Checking by passing initial event and getting initial state',
      build: () => loginBloc,
      act: (bloc) => bloc.add(InitialEvent()),
      expect: () => [
        isA<InitialState>(),
      ],
    );


    blocTest(
      'Checking by passing validation event and getting error state with error message',
      build: () => loginBloc,
      act: (bloc) {
        bloc.add(ValidateEvent());
      },
      expect: () => [
        isA<ErrorState>().having((p0) => p0.errorMessage, "description",
            "Please Enter Login Details"),
      ],
    );

    blocTest(
        'By passing username and password to TextEditingController and check success validation state',
        build: () => loginBloc,
        act: (bloc) {
          bloc.userNameController.text = "Username";
          bloc.passwordController.text = "Password";
          bloc.add(ValidateEvent());
        },
        expect: () => [
          isA<SuccessValidationState>(),
        ]);

    tearDown(() {
      loginBloc.close();
    });
  });
}