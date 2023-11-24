

import 'package:flutter_exercise/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/ui/bottom_navigation/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

main(){
  group('Test mutation', () {
    MockClient mockHttpClient;
    HttpLink httpLink;
    late ValueNotifier<GraphQLClient> client;

    setUp(() async {
      await initHiveForFlutter();
      mockHttpClient = MockClient();
      httpLink = HttpLink(
        'http://localhost:4000/',
        httpClient: mockHttpClient,
      );
      client = ValueNotifier(
        GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: httpLink,
        ),
      );
    });

    testWidgets('Check Home screen', (WidgetTester tester) async {
      await tester.pumpWidget(GraphQLProvider(
        client: client,
        child: HomePage(),
      ));
    });
  });

}