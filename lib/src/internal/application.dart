import 'package:banking/src/presentation/views/home.dart';
import 'package:banking/src/presentation/views/login/login.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Banking',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
