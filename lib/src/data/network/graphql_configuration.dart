import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static final WebSocketLink webSocketLink = WebSocketLink(
    'wss://divine-goat-11.hasura.app/v1/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(seconds: 30),
      initialPayload: () async {
        return {
          'headers': {
            'content-Type': 'application/json',
            'x-hasura-admin-secret':
                'lEvCor8cURLJjfidfsttLps3gOKQwKTLKPf9zrG8sEQfW1WSy6haU6i5gtBPzbEp',
          }
        };
      },
    ),
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: webSocketLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: webSocketLink,
      cache: GraphQLCache(
        store: InMemoryStore(),
      ),
    );
  }
}
