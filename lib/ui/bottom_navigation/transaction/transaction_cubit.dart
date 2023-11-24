import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(InitialState());

}

class TransactionState{}

class InitialState extends TransactionState{}
