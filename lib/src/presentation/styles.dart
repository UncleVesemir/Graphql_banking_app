import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static final HexColor gradientDark = HexColor('#EBD0D0');
  static final HexColor gradientLow = HexColor('#F4F5F9');

  static HexColor mainMid = HexColor('#001064');
  static HexColor mainLow = HexColor('#5f5fc4');
  static HexColor mainDark = HexColor('#001064');
  static HexColor mainScaffold = HexColor('#FFFFFF');
  static HexColor language = HexColor('#FEECE3');
  static HexColor units = HexColor('#E3F7FD');
  static HexColor notifications = HexColor('#FFE2EA');
  static HexColor green = HexColor('#58CB70');

  static final BoxDecoration appBackgroundGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        AppColors.gradientDark,
        AppColors.gradientLow,
      ],
    ),
  );

  static final LinearGradient appBackgroundGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      AppColors.gradientDark,
      AppColors.gradientLow,
    ],
  );

  static final LinearGradient appBackgroundGradientInactive = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      AppColors.gradientDark.withOpacity(0.6),
      AppColors.gradientLow.withOpacity(0.6),
    ],
  );
}

class AppTextStyles {
  static final TextStyle creditCardBig = TextStyle(
    fontFamily: 'Open Sans SemiBold',
    color: Colors.black.withOpacity(0.5),
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle receiptBig = TextStyle(
    fontFamily: 'Open Sans SemiBold',
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle receiptLow = TextStyle(
    fontFamily: 'Open Sans',
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle receiptLowBold = TextStyle(
    fontFamily: 'Open Sans Bold',
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle receiptMedium = TextStyle(
    fontFamily: 'Open Sans SemiBold',
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle settingsBig = TextStyle(
    fontFamily: 'Open Sans SemiBold',
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle settingsMid = TextStyle(
    fontFamily: 'Open Sans Bold',
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle settingsSmall = TextStyle(
    fontFamily: 'Open Sans SemiBold',
    color: Colors.grey.withOpacity(0.8),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle boldMediumValue = TextStyle(
    fontSize: 22,
    fontFamily: 'Open Sans Bold',
  );

  static const TextStyle boldMediumValueBlack = TextStyle(
    fontSize: 22,
    color: Colors.black,
    fontFamily: 'Open Sans Bold',
  );

  static const TextStyle boldLowValueBlack = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: 'Open Sans Semi  Bold',
  );

  static const TextStyle hyperLinkInactive = TextStyle(
    fontSize: 13,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hyperLinkActive = TextStyle(
    fontSize: 13,
    color: Colors.deepOrange,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle errorValueBlack = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle errorValueOrange = TextStyle(
    fontSize: 13,
    color: Colors.deepOrange,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle boldLowValueWhiteMedium = TextStyle(
    fontSize: 17,
    fontFamily: 'Open Sans SemiBold',
    color: Colors.white,
  );

  static const TextStyle regularLowValueGrey = TextStyle(
    fontSize: 15,
    fontFamily: 'Open Sans',
    color: Colors.grey,
  );

  static const TextStyle signInGrey = TextStyle(
    fontSize: 26,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static const TextStyle signInBlack = TextStyle(
    fontSize: 36,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle loginGrey = TextStyle(
    fontSize: 20,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static const TextStyle loginBlackSemi = TextStyle(
    fontSize: 20,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle friendsSmallBlack = TextStyle(
    fontSize: 14,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const TextStyle friendsSmallGrey = TextStyle(
    fontSize: 14,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w800,
    color: Colors.grey,
  );

  static const TextStyle loginBlack = TextStyle(
    fontSize: 36,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const TextStyle semiMediumValue = TextStyle(
    fontSize: 24,
    fontFamily: 'Open Sans SemiBold',
    fontWeight: FontWeight.w100,
  );

  static const TextStyle boldLowValueWhite = TextStyle(
    fontSize: 15,
    fontFamily: 'Open Sans Bold',
    color: Colors.white,
  );

  static const TextStyle regularLowValueWhite = TextStyle(
    fontSize: 15,
    fontFamily: 'Open Sans',
    color: Colors.white,
  );

  static const TextStyle boldMediumValueWhite = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    fontFamily: 'Open Sans Bold',
    color: Colors.white,
  );
}
