import 'package:banking/main.dart';
import 'package:banking/src/data/models/user.dart';
import 'package:banking/src/data/network/query_mutation.dart';
import 'package:banking/src/presentation/blocs/bloc/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/utils/helper_widgets.dart';
import 'package:banking/src/presentation/views/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert' as convert;

import 'register.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isActive = false;

  void _checkFields() {
    setState(() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        _isActive = true;
      } else {
        _isActive = false;
      }
    });
  }

  void _login() async {
    final SignInRegisterBloc userBloc =
        BlocProvider.of<SignInRegisterBloc>(context);
    var email = _emailController.text.trim().toLowerCase();
    var password = _passwordController.text.trim().toLowerCase();
    userBloc.add(SignInEvent(email: email, password: password));
  }

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
            onChanged: (value) => _checkFields(),
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

  Widget _signInButtons(SignInRegisterState state) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: 'Don\'t have an account? ',
            style: AppTextStyles.hyperLinkInactive,
            children: <TextSpan>[
              TextSpan(
                text: 'Register',
                style: AppTextStyles.hyperLinkActive,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => UtilsWidget.navigateToScreen(
                      context, const RegisterPage()),
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
              backgroundColor: MaterialStateProperty.all(
                  _isActive ? Colors.deepOrange : Colors.deepOrange[200]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            onPressed: _isActive ? () async => _login() : null,
            child: state is SignInRegisterLoadingState
                ? const SpinKitWave(color: Colors.white, size: 25)
                : const Text('Sign In', style: AppTextStyles.boldLowValueWhite),
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

  Widget _buildErrorMessage(SignInRegisterState state) {
    if (state is SignInRegisterErrorState) {
      return Text(state.error.toString());
    }
    return Container();
  }

  Widget _buildBody(SignInRegisterState state) {
    return Container(
      decoration: AppColors.appBackgroundGradientDecoration,
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
                  const SizedBox(height: 25),
                  _buildErrorMessage(state),
                ],
              ),
              _signInButtons(state),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInRegisterBloc, SignInRegisterState>(
      builder: (context, state) {
        return BlocListener<SignInRegisterBloc, SignInRegisterState>(
          listener: (context, state) {
            if (state is SignInRegisterDoneState) {
              final SignInRegisterBloc userBloc =
                  BlocProvider.of<SignInRegisterBloc>(context);
              userBloc.add(FetchFriendsEvent(userUuid: state.user.uuid));
              UtilsWidget.navigateToScreen(context, const Home());
            }
            if (state is SignInRegisterErrorState) {
              UtilsWidget.showInfoSnackBar(context, state.error);
            }
          },
          child: Scaffold(
            body: _buildBody(state),
          ),
        );
      },
    );
  }
}
