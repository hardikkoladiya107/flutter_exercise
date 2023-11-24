
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());



  passEvent(){
    emit(AccountInitial());
  }
}

class AccountState{}

class AccountInitial extends AccountState{}
