part of 'login_bloc.dart';


@immutable
abstract class LoginState{}

class InitialState extends LoginState{}

class ErrorState extends LoginState{
  String? errorMessage;
  ErrorState({this.errorMessage});
}

class SuccessValidationState extends LoginState{

}


