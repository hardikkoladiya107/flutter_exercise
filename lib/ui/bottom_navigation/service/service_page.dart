import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/ui/bottom_navigation/service/service_cubit.dart';
import 'package:flutter_exercise/utils/common_extension.dart';

import '../../../other/app_string.dart';
import '../../../routes/custom_router.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (context) => ServiceCubit(),
      child: const ServiceWidget(),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            serviceItem(loans).onTap(() {
              showErrorSnack(context);
            }),
            serviceItem(statements).onTap(() {
              CustomNavigationHelper.router.push(CustomNavigationHelper.statement);
            }),
            serviceItem(contacts).onTap(() {
              CustomNavigationHelper.router.push(CustomNavigationHelper.contact);
            }),
          ],
        ),
      ),
    );
  }

  showErrorSnack(BuildContext context) {
    var snackBar = SnackBar(
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
      content: (somethingWentWrong).text(),
      padding: const EdgeInsets.all(15),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget serviceItem(String value) {
    return Card(
      child: Container(
        child:
            value.text(fontSize: 15, weight: FontWeight.w900).padding(all: 15),
      ).center,
    );
  }
}
