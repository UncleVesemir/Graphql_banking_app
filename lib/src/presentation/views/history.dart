import 'package:banking/src/presentation/blocs/sign_in_register/sign_in_register_bloc.dart';
import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/custom_clip.dart';
import 'package:banking/src/presentation/widgets/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Widget _loaded(SignInRegisterLoadedState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: SafeArea(
        child: ListView(
          children: const [
            SizedBox(height: 20),
            ReceiptDataWidget(),
            ReceiptDataWidget(),
            ReceiptDataWidget(),
            ReceiptDataWidget(),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return const SpinKitWave(
      color: Colors.deepOrange,
    );
  }

  Widget _error(SignInRegisterErrorState state) {
    return Center(child: Text(state.error));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInRegisterBloc, SignInRegisterState>(
      builder: (context, state) {
        return Container(
          decoration: AppColors.appBackgroundGradientDecoration,
          child: SafeArea(
            child: Column(
              children: [
                ClipShadowPath(
                  shadow: Shadow(
                    offset: const Offset(0, 0),
                    color: Colors.grey.withOpacity(0.0),
                    blurRadius: 10,
                  ),
                  clipper: TabClipper(),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'Transactions History',
                        style: AppTextStyles.friendsSmallGrey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: state is SignInRegisterLoadedState
                      ? _loaded(state)
                      : state is SignInRegisterLoadingState
                          ? _loading()
                          : state is SignInRegisterErrorState
                              ? _error(state)
                              : Container(color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
