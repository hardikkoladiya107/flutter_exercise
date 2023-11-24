part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitialEvent extends LoginEvent{}
class ValidateEvent extends LoginEvent{}
class ShowPassword extends LoginEvent{}