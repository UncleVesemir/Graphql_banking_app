import 'package:banking/main.dart';
import 'package:banking/src/data/network/query_mutation.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/views/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  QueryMutation addMutation = QueryMutation();

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Let\'s sign you in',
          style: AppTextStyles.signInBlack,
        ),
        SizedBox(height: 10),
        Text(
          'Welcome back.\nYou\'ve been missed!',
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
        const Text('Don\'t have an account? Register'),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () async {
            if (_emailController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty) {
              var email = _emailController.text.trim();
              var password = _passwordController.text.trim();
              GraphQLClient _client = graphQLConfiguration.clientToQuery();
              QueryResult result = await _client.query(
                QueryOptions(
                  document: gql(addMutation.login()),
                  variables: addMutation.loginVariables(email, password),
                ),
              );
              print(result.data);
              if (result.hasException) {
                print(result.exception);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => const Home()));
              }
            }
          },
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Text('Sign In', style: AppTextStyles.boldLowValueWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextInputs() {
    return Column(
      children: [
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
