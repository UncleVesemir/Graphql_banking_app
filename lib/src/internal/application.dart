import 'package:banking/src/data/network/graphql_configuration.dart';
import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/presentation/blocs/bloc/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final graphQLRepositiry = GraphQLRepositiry();
    return GraphQLProvider(
      client: graphQLConfiguration.client,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignInRegisterBloc>(
              create: (context) =>
                  SignInRegisterBloc(graphQLRepositiry: graphQLRepositiry)),
        ],
        child: const MaterialApp(
          title: 'Banking',
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ),
      ),
    );
  }
}
