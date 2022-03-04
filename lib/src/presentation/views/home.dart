import 'package:banking/src/presentation/styles.dart';
import 'package:banking/src/presentation/utils/clippers.dart';
import 'package:banking/src/presentation/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _buildCard() {
    return ClipPath(
      clipper: CardClipper(),
      child: Container(
        color: Colors.deepOrange,
        width: 300,
        height: 400,
      ),
    );
  }

  Widget _buildSheet() {
    return DraggableScrollableSheet(
      minChildSize: 0.4,
      initialChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (BuildContext context, ScrollController controller) {
        return ClipPath(
          clipper: SheetClipper(),
          child: Container(
            color: Colors.white,
            child: MediaQuery.removePadding(
              context: context,
              child: ListView(
                physics: const ClampingScrollPhysics(),
                controller: controller,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 175.0, right: 175),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: AppColors.appBackgroundGradient,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Expanded(flex: 2, child: _buildCard()),
              const Spacer(flex: 2),
            ],
          ),
        ),
        _buildSheet(),
        CustomAppBar(
          onSelected: (index) {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
