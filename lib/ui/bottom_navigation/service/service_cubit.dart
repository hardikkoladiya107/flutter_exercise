import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(InitialState());

}

class ServiceState{}

class InitialState extends ServiceState{}
