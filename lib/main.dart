import 'package:flutter/material.dart';
import 'package:flutter_exercise/routes/custom_router.dart';
import 'package:flutter_exercise/utils/shared_pref.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'network/graph_helper.dart';


@GenerateMocks([http.Client])
Future<void> main() async {

  await initHiveForFlutter();
  GraphHelper.instance;
  CustomNavigationHelper.instance;
  await preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphHelper.instance.client,
      child: MaterialApp.router(
        title: 'Flutter Exercise',
        debugShowCheckedModeBanner: false,
        routerConfig: CustomNavigationHelper.router,
      ),
    );
  }
}

class MockGraphQLClient extends Mock implements GraphQLClient {}


class MockClient extends Mock implements http.Client {}
