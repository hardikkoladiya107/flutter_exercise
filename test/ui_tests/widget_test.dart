import 'package:flutter/material.dart';
import 'package:flutter_exercise/main.dart';
import 'package:flutter_exercise/network/graph_helper.dart';
import 'package:flutter_exercise/ui/bottom_navigation/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<GraphQLClient>(),
])
void main() {
  late MockGraphQLClient mockGraphQLClient;

  setUpAll(() {
    mockGraphQLClient = MockGraphQLClient();
  });

  void mockQueryResponse({
    bool isLoading = false,
    String? errorMessage,
  }) {
    final options = QueryOptions(
      document: gql(GraphHelper.homeQuery),
    );
    when(
      mockGraphQLClient.query(options),
    ).thenAnswer(
      (_) => Future.value(
        QueryResult(
          options: options,
          source:
              isLoading ? QueryResultSource.loading : QueryResultSource.network,
          exception: errorMessage != null
              ? OperationException(
                  graphqlErrors: [
                    GraphQLError(message: errorMessage),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  testWidgets(
      'Home page testing',
      (WidgetTester tester) async {
    mockQueryResponse();
    await tester.pumpWidget(
        GraphQLProvider(
          client: ValueNotifier<GraphQLClient>(mockGraphQLClient),
          child: MaterialApp(home: HomePage(),),)

    );
    await tester.pump();
    expect(find.widgetWithText(Text, 'Krajcik Glens'), findsOneWidget);
  });

}


