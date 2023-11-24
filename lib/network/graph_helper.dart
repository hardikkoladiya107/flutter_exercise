import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphHelper {
  static final GraphHelper _instance = GraphHelper._internal();

  static GraphHelper get instance => _instance;

  late HttpLink httpLink;
  late ValueNotifier<GraphQLClient> client;

  GraphHelper._internal() {
    httpLink = HttpLink(
      'http://192.168.1.5:4000/',///Please change this url
    );

    client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }

 static String homeQuery = """query getHome {
  home {
    name
    accountNumber
    balance
    currency
    address {
      streetName
      buildingNumber
      townName
      postCode
      country
    }
    recentTransactions {
      date
      description
      amount
      fromAccount
      toAccount
    }
    upcomingBills {
      date
      description
      amount
      fromAccount
      toAccount
    }
  }
}""";


  static String accountQuery = """query getAccounts {
  accounts {
    id
    accountNumber
    accountType
    balance
    accountHolder
  }
}""";

  static String transactionQuery = """query getTransactions {
  transactions {
    date
    description
    amount
    fromAccount
    toAccount
  }
}""";


  static String contactQuery = """query getContacts {
  contacts
}""";

  static String statementQuery = """query getStatements {
  statements {
    date
    description
    amount
  }
}""";



}
