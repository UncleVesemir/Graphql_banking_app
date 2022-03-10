import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    'https://divine-goat-11.hasura.app/v1/graphql',
    defaultHeaders: {
      "content-Type": "application/json",
      "x-hasura-admin-secret":
          "lEvCor8cURLJjfidfsttLps3gOKQwKTLKPf9zrG8sEQfW1WSy6haU6i5gtBPzbEp",
    },
  );

  static Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }
}
