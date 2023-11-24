import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../other/app_string.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(InitialState()) {
    on<LoginEvent>((event, emit) {
      if (event is ValidateEvent) {
        emit(isValidate());
      }else if(event is ShowPassword){
        emit(showHidePassword());
      }else{
        emit(InitialState());
      }
    });
  }

  bool showPassword = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginState showHidePassword() {
    showPassword = !showPassword;
    return InitialState();
  }

  LoginState isValidate() {
    if (userNameController.text.trim().isEmpty &&
        passwordController.text.trim().isEmpty) {
      return ErrorState(errorMessage: pleaseEnterLoginDetails);
    }
    if (userNameController.text.trim().isEmpty) {
      return ErrorState(errorMessage: pleaseEnterUsername);
    }
    if (passwordController.text.trim().isEmpty) {
      return ErrorState(errorMessage: pleaseEnterPassword);
    }
    return SuccessValidationState();
  }
}
