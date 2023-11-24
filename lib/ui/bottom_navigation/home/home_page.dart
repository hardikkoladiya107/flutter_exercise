import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/other/app_string.dart';
import 'package:flutter_exercise/utils/common_extension.dart';
import 'package:flutter_exercise/utils/shared_pref.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../models/home_model.dart';
import '../../../network/graph_helper.dart';
import 'home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  userName(),
                  homeDetailData(),
                ],
              ),
            ),
          ).padding(
            left: 10,
            right: 10,
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget userName() {
    var username = preferences.getString(key: SharedKeys.userName);
    return Card(
      child: Container(
        child: username
            .text(fontSize: 20, weight: FontWeight.w900)
            .padding(all: 20),
      ).center,
    );
  }

  Widget homeDetailData() {
    return Query(
      options: QueryOptions(
        document: gql(GraphHelper.homeQuery),
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (
        QueryResult result, {
        VoidCallback? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.hasException) {
          if ((result.exception?.graphqlErrors ?? []).isNotEmpty) {
            return errorCard(result.exception?.graphqlErrors[0].message ??
                somethingWentWrong);
          }
          return errorCard(somethingWentWrong);
        }

        if (result.isLoading) {
          return loadingCard();
        }

        HomeModel homeModel = HomeModel.fromJson(result.data);

        return Column(
          children: [
            addressWidget(homeModel.home?.address),
            recentTransaction(homeModel.home?.recentTransactions),
            upcomingBills(homeModel.home?.upcomingBills),
          ],
        );
      },
    );
  }

  Widget errorCard(String error) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: error
                  .text(
                    weight: FontWeight.w600,
                    fontSize: 16,
                  )
                  .padding(all: 10))
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

  Widget upcomingBills(List<UpcomingBills>? upcomingBills) {
    return upcomingBills != null && upcomingBills.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              upcomingBillsText
                  .text(
                    fontSize: 20,
                    weight: FontWeight.w700,
                  )
                  .padding(left: 10, top: 10, bottom: 10),
              ...upcomingBills
                  .map(
                    (e) => Card(
                      child: Column(
                        children: [
                          txtWithKeyWidget(date, e.date),
                          txtWithKeyWidget(description, e.description),
                          txtWithKeyWidget(amount, e.amount.toString()),
                          txtWithKeyWidget(fromAccount, e.fromAccount),
                          txtWithKeyWidget(toAccount, e.toAccount),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          )
        : Container();
  }

  Widget recentTransaction(List<RecentTransactions>? recentTransactions) {
    return recentTransactions != null && recentTransactions.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              recentTransactionText
                  .text(
                    fontSize: 20,
                    weight: FontWeight.w700,
                  )
                  .padding(left: 10, top: 10, bottom: 10),
              ...recentTransactions
                  .map((e) => Card(
                        child: Column(
                          children: [
                            txtWithKeyWidget(date, e.date),
                            txtWithKeyWidget(description, e.description),
                            txtWithKeyWidget(amount, e.amount.toString()),
                            txtWithKeyWidget(fromAccount, e.fromAccount),
                            txtWithKeyWidget(toAccount, e.toAccount),
                          ],
                        ),
                      ))
                  .toList(),
            ],
          )
        : Container();
  }

  Widget addressWidget(Address? addressData) {
    return addressData != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              address
                  .text(
                    fontSize: 20,
                    weight: FontWeight.w700,
                  )
                  .padding(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
              Card(
                child: Column(
                  children: [
                    txtWithKeyWidget(streatName, addressData.streetName),
                    txtWithKeyWidget(
                        buildingNumber, addressData.buildingNumber),
                    txtWithKeyWidget(townName, addressData.townName),
                    txtWithKeyWidget(postCode, addressData.postCode),
                    txtWithKeyWidget(country, addressData.country),
                  ],
                ),
              )
            ],
          )
        : Container();
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
}
