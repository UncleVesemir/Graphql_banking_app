import 'dart:developer';

import 'package:banking/main.dart';
import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/query_mutation.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/helper_widgets.dart';
import 'package:banking/src/presentation/views/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  QueryMutation addMutation = QueryMutation();

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Let\'s create your new account',
          style: AppTextStyles.signInBlack,
        ),
        SizedBox(height: 10),
        Text(
          'It does not take much time!',
          style: AppTextStyles.signInGrey,
        ),
      ],
    );
  }

  Widget _buildTextField(
      String hint, TextEditingController controller, bool hideText) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            obscureText: hideText,
            obscuringCharacter: '*',
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButtons() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: 'Already have an account? ',
            style: AppTextStyles.hyperLinkInactive,
            children: <TextSpan>[
              TextSpan(
                text: 'Sign In',
                style: AppTextStyles.hyperLinkActive,
                recognizer: TapGestureRecognizer()
                  ..onTap = () =>
                      UtilsWidget.navigateToScreen(context, const SignInPage()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: 70,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            onPressed: () async {
              if (_emailController.text.isNotEmpty &&
                  _passwordController.text.isNotEmpty) {
                var name = _nameController.text.trim().toLowerCase();
                var email = _emailController.text.trim().toLowerCase();
                var password = _passwordController.text.trim().toLowerCase();
                GraphQLClient _client = graphQLConfiguration.clientToQuery();
                QueryResult result = await _client.query(
                  QueryOptions(
                    document: gql(addMutation.createUser()),
                    variables:
                        addMutation.createUserVariables(email, password, name),
                  ),
                );
                if (result.hasException) {
                  UtilsWidget.showInfoSnackBar(
                    context,
                    'This email already taken',
                  );
                } else {
                  if (result.data!['user'].toString().length > 10) {
                    print(result.data!['user'].toString());
                    print(UserModel.fromJson(result.data!['user'][0]));
                    UtilsWidget.navigateToScreen(context, const Home());
                  } else {
                    UtilsWidget.showInfoSnackBar(
                      context,
                      'Something gone wrong. Try again',
                    );
                  }
                }

                if (result.hasException) {
                  print(result.exception);
                } else {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext ctx) => const Home()));
                }
              }
            },
            child:
                const Text('Register', style: AppTextStyles.boldLowValueWhite),
          ),
        ),
      ],
    );
  }

  Widget _buildTextInputs() {
    return Column(
      children: [
        _buildTextField('Your name', _nameController, false),
        const SizedBox(height: 15),
        _buildTextField('Your email', _emailController, false),
        const SizedBox(height: 15),
        _buildTextField('Password', _passwordController, true),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: AppColors.appBackgroundGradient,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(),
                  const SizedBox(height: 65),
                  _buildTextInputs(),
                ],
              ),
              _signInButtons(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
