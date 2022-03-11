import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppColors {
  static final HexColor gradientDark = HexColor('#EBD0D0');
  static final HexColor gradientLow = HexColor('#F4F5F9');

  static final BoxDecoration appBackgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        AppColors.gradientDark,
        AppColors.gradientLow,
      ],
    ),
  );
}

class AppTextStyles {
  static const TextStyle boldMediumValue = TextStyle(
    fontSize: 22,
    fontFamily: 'Fredoka Bold',
  );

  static const TextStyle boldLowValueBlack = TextStyle(
    fontSize: 17,
    color: Colors.black,
    fontFamily: 'Fredoka SemiBold',
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
    fontFamily: 'Fredoka SemiBold',
    color: Colors.white,
  );

  static const TextStyle regularLowValueGrey = TextStyle(
    fontSize: 15,
    fontFamily: 'Fredoka',
    color: Colors.grey,
  );

  static const TextStyle signInGrey = TextStyle(
    fontSize: 26,
    // fontFamily: 'Fredoka SemiBold',
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static const TextStyle signInBlack = TextStyle(
    fontSize: 36,
    // fontFamily: 'Fredoka SemiBold',
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle loginGrey = TextStyle(
    fontSize: 20,
    // fontFamily: 'Fredoka SemiBold',
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static const TextStyle loginBlack = TextStyle(
    fontSize: 36,
    // fontFamily: 'Fredoka SemiBold',
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const TextStyle semiMediumValue = TextStyle(
    fontSize: 24,
    fontFamily: 'Fredoka SemiBold',
    fontWeight: FontWeight.w100,
  );

  static const TextStyle boldLowValueWhite = TextStyle(
    fontSize: 15,
    // fontFamily: 'Fredoka Bold',
    color: Colors.white,
  );

  static const TextStyle regularLowValueWhite = TextStyle(
    fontSize: 15,
    // fontFamily: 'Fredoka',
    color: Colors.white,
  );

  static const TextStyle boldMediumValueWhite = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    // fontFamily: 'Fredoka Bold',
    color: Colors.white,
  );
}
