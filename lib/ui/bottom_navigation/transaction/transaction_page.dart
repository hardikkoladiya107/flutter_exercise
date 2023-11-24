import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/ui/bottom_navigation/transaction/transaction_cubit.dart';
import 'package:flutter_exercise/utils/common_extension.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../models/account_model.dart';
import '../../../models/transaction_model.dart';
import '../../../network/graph_helper.dart';
import '../../../other/app_string.dart';
import '../../../routes/custom_router.dart';

class TransactionPage extends StatelessWidget {
  final Accounts account;

  const TransactionPage({Key? key, required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCubit>(
      create: (context) => TransactionCubit(),
      child: TransactionWidget(
        account: account,
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  final Accounts account;

  const TransactionWidget({
    Key? key,
    required this.account,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            accountDetail("Account Number", account.accountNumber),
            accountDetail("Balance", account.balance.toString()),
            Expanded(
              child: tabBarWidget(),
            )
          ],
        ),
      ),
    );
  }

  tabBarWidget() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(icon: "Transactions".text(fontSize: 16, textColor: Colors.black)),
              Tab(icon: "Details".text(fontSize: 16, textColor: Colors.black)),
            ],
          ),
            Expanded(
            child: TabBarView(
              children: [
                transactionList(),
                detailCard(account),
              ],
            ),
          )
        ],
      ),
    );
    return;
  }


  Widget detailCard(Accounts account){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          txtWithKeyWidget("Id",account.id),
          txtWithKeyWidget("Account Number",account.accountNumber),
          txtWithKeyWidget("Account Type",account.accountType.toString()),
          txtWithKeyWidget("Balance",account.balance.toString()),
          txtWithKeyWidget("account Holder",account.accountHolder.toString()),
        ],
      ),
    ).padding(all: 10);
  }

  Widget transactionList(){
    return Query(
      options: QueryOptions(
        document: gql(GraphHelper.transactionQuery),
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

        TransactionData accountData = TransactionData.fromJson(result.data);

        return ListView.builder(
          itemBuilder: (context, index) {
            return transactionItem(
              accountData.transactions?[index],
            );
          },
          itemCount: accountData.transactions?.length,
        );
      },
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

  Widget errorCard(String d) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          somethingWentWrong
              .text(
            weight: FontWeight.w500,
          )
              .padding(all: 15)
        ],
      ),
    );
  }


  Widget transactionItem(Transactions? transaction ) {
    return Card(
      child: Column(
        children: [
          txtWithKeyWidget("Date",transaction?.date),
          txtWithKeyWidget("Description",transaction?.description),
          txtWithKeyWidget("Amount",transaction?.amount.toString()),
          txtWithKeyWidget("From Account",transaction?.fromAccount.toString()),
          txtWithKeyWidget("To Account",transaction?.toAccount.toString())
        ],
      ),
    ).onClick(() {

    });
  }

  Widget accountDetail(String? key, String? value) {
    return value != null
        ? Card(
            child: Container(
              child: txtWithKeyWidget(key, value),
            ).center,
          )
        : Container();
  }

  txtWithKeyWidget(String? key, String? value) {
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
}
