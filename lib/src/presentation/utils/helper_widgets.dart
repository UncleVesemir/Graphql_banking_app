import 'package:banking/src/presentation/styles.dart';
import 'package:flutter/material.dart';

class UtilsWidget {
  static void showInfoSnackBar(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              error,
              style: AppTextStyles.errorValueBlack,
            ),
            ElevatedButton(
              onPressed: scaffold.hideCurrentSnackBar,
              child: const Text(
                'Close',
                style: AppTextStyles.errorValueOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void navigateToScreen(BuildContext context, dynamic T) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => T));
  }
}
