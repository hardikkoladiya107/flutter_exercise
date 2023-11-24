import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/ui/bottom_navigation/statement/statement_bloc.dart';
import 'package:flutter_exercise/utils/common_extension.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../models/statement_model.dart';
import '../../../network/graph_helper.dart';
import '../../../other/app_string.dart';

class StatementPage extends StatelessWidget {
  const StatementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatementBloc>(
      create: (context) => StatementBloc(),
      child: StatementWidget(),
    );
  }
}

class StatementWidget extends StatelessWidget {
  StatementWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: Column(
        children: [
          dropdownButton(context),
          Expanded(
            child: statementWidget(),
          ),
        ],
      ),
    );
  }

  Widget dropdownButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
          child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          isExpanded: true,
          value: context.watch<StatementBloc>().state.value,
          items: context.read<StatementBloc>().dropDownList.map(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value.text(),
              );
            },
          ).toList(),
          onChanged: (value) {
            if (value != null) {
              context
                  .read<StatementBloc>()
                  .add(DropdownSelectionEvent()..value = value);
            }
          },
        ),
      )),
    );
  }

  Widget statementWidget() {
    return Query(
      options: QueryOptions(
        document: gql(GraphHelper.statementQuery),
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

        StatementData statementData = StatementData.fromJson(result.data);

        return BlocConsumer<StatementBloc, StatementState>(
          builder: (context, state) {
            List<Statements> statementList = [];

            if (context.read<StatementBloc>().state.value ==
                "Select Year") {
              statementList.addAll(statementData.statements ?? []);
            } else {
              statementList.addAll(statementData.statements
                      ?.where((e) =>
                          e.date?.split("-").first.toLowerCase() ==
                          context
                              .read<StatementBloc>()
                              .state.value
                              .toLowerCase())
                      .toList() ??
                  []);
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                return accountItem(
                  statementList[index],
                );
              },
              itemCount: statementList.length,
            );
          },
          listener: (context, state) {},
        );
      },
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

  Widget accountItem(Statements? statement) {
    return Card(
      child: Column(
        children: [
          txtWithKeyWidget(accountHolder, statement?.date),
          txtWithKeyWidget(accountNumber, statement?.description),
          txtWithKeyWidget(balance, statement?.amount.toString())
        ],
      ),
    ).onClick(() {});
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
              Expanded(
                child: value.text(
                  fontSize: 15,
                  maxLines: 2,
                  overFlow: TextOverflow.ellipsis,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ).padding(all: 10)
        : Container();
  }
}
