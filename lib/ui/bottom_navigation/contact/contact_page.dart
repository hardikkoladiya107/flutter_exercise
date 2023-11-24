import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exercise/ui/bottom_navigation/contact/contact_cubit.dart';
import 'package:flutter_exercise/utils/common_extension.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../models/account_model.dart';
import '../../../network/graph_helper.dart';
import '../../../other/app_string.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactCubit>(
      create: (context) => ContactCubit(),
      child: const ContactWidget(),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: contacts(),
    );
  }

  Widget contacts() {
    return Query(
      options: QueryOptions(
        document: gql(GraphHelper.contactQuery),
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

        return Container();
      },
    );
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
}
