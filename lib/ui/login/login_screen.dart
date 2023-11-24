import 'package:flutter/material.dart';
import 'package:flutter_exercise/utils/common_extension.dart';
import '../../generated/assets.dart';
import '../../other/app_string.dart';
import '../../routes/custom_router.dart';
import '../../utils/shared_pref.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import 'login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is ErrorState) {
          var snackBar = SnackBar(
            content: (state.errorMessage ?? somethingWentWrong).text(),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is SuccessValidationState) {
          context.read<LoginBloc>().add(InitialEvent());
          await preferences.save(key: SharedKeys.userName, data: context.read<LoginBloc>().userNameController.text.trim());
          context.read<LoginBloc>().userNameController.clear();
          context.read<LoginBloc>().passwordController.clear();
          CustomNavigationHelper.router.go(
            CustomNavigationHelper.homePath,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userNameTextField(context),
            passwordTextField(context),
            loginButton(context)
          ],
        ).padding(
          left: 30,
          right: 30,
        ),
      ),
    );
  }

  Widget userNameTextField(BuildContext context) {
    return AppTextField(
      controller: context.read<LoginBloc>().userNameController,
      hint: userName,
      hintColor: Colors.grey,
      maxLines: 1,
      onchange: (value) {
        if (context.read<LoginBloc>().state is SuccessValidationState) {
          context.read<LoginBloc>().add(InitialEvent());
        }
      },
      prefixIcon: Image.asset(
        Assets.iconsUser,
        height: 20,
        width: 20,
      ).padding(left: 8, right: 8),
    );
  }

  Widget passwordTextField(BuildContext context) {
    return AppTextField(
      controller: context.read<LoginBloc>().passwordController,
      hint: password,
      hintColor: Colors.grey,
      obscureText: !context.watch<LoginBloc>().showPassword,
      maxLines: 1,
      onchange: (value) {
        if (context.read<LoginBloc>().state is SuccessValidationState) {
          context.read<LoginBloc>().add(InitialEvent());
        }
      },
      sufixIcon: Icon(
        context.watch<LoginBloc>().showPassword
            ? Icons.visibility
            : Icons.visibility_off,
        color: Colors.black,
        size: 22,
      ).onClick(
        () {
          context.read<LoginBloc>().add(ShowPassword());
        },
      ).padding(all: 10),
      prefixIcon: Image.asset(
        Assets.iconsLock,
        height: 20,
        width: 20,
      ).padding(
        left: 8,
        right: 8,
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return AppButton(
      onPress: () {
        context.read<LoginBloc>().add(ValidateEvent());
      },
      borderValue: 5,
      text: login,
    ).padding(
      top: 20,
    );
  }
}
