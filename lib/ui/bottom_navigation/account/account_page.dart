import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/utils/common_extension.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../models/account_model.dart';
import '../../../models/home_model.dart';
import '../../../network/graph_helper.dart';
import '../../../other/app_string.dart';
import '../../../routes/custom_router.dart';
import 'account_cubit.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountCubit>(
      create: (context) => AccountCubit(),
      child: const AccountWidget(),
    );
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: accounts(),
      ),
    );
  }

  Widget accounts() {
    return Query(
      options: QueryOptions(
        document: gql(GraphHelper.accountQuery),
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.hasException) {
          if((result.exception?.graphqlErrors ?? []).isNotEmpty){
            return errorCard(result.exception?.graphqlErrors[0].message ?? somethingWentWrong);
          }
          return errorCard(somethingWentWrong);
        }

        if (result.isLoading) {
          return loadingCard();
        }

        AccountData accountData = AccountData.fromJson(result.data);

        return ListView.builder(
          itemBuilder: (context, index) {
            return accountItem(
              accountData.accounts?[index],
            );
          },
          itemCount: accountData.accounts?.length,
        );
      },
    );
  }

  Widget accountItem(Accounts? account) {
    return Card(
      child: Column(
        children: [
          txtWithKeyWidget(accountHolder,account?.accountHolder),
          txtWithKeyWidget(accountNumber,account?.accountNumber),
          txtWithKeyWidget(balance,account?.balance.toString())
        ],
      ),
    ).onClick(() {
      CustomNavigationHelper.router.push(
        CustomNavigationHelper.transaction,extra: account
      );
    });
  }

  txtWithKeyWidget(String key, String? value) {
    return (value != null && value.isNotEmpty)
        ? Row(
      children: [
        key.text(
          fontSize: 15,
          weight: FontWeight.w600,
        ),
        const Spacer(),
        value.text(
          fontSize: 15,
          weight: FontWeight.w500,
        ),
      ],
    ).padding(all: 10)
        : Container();
  }

  Widget errorCard(String error) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: error
              .text(
            weight: FontWeight.w600,
            fontSize: 16,
          ).padding(all: 10))
        ],
      ),
    );
  }

  Widget loadingCard() {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loading
              .text(
                weight: FontWeight.w500,
              )
              .padding(all: 15)
        ],
      ),
    );
  }
}
