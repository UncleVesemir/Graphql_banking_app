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

  static const TextStyle boldLowValue = TextStyle(
    fontSize: 15,
    fontFamily: 'Fredoka Bold',
  );

  static const TextStyle regularLowValueGrey = TextStyle(
    fontSize: 15,
    fontFamily: 'Fredoka',
    color: Colors.grey,
  );

  static const TextStyle semiMediumValue = TextStyle(
    fontSize: 24,
    fontFamily: 'Fredoka SemiBold',
    fontWeight: FontWeight.w100,
  );

  static const TextStyle boldLowValueWhite = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w800,
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
