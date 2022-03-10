import 'package:banking/src/data/network/graphql_provider.dart';
import 'package:banking/src/internal/application.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  runApp(
    GraphQLProvider(
      client: graphQLConfiguration.client,
      child: const Application(),
    ),
  );
}
