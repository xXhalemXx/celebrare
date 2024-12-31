library text_style;

import 'package:celebrare/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

//
class FontWeightHelper {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

//
class AppTextStyles {
  // to calculate the height of the text use this ratio font height in design divided by font size

  // we add font family and size and color with percentage and type then font height
  static TextStyle loraFont20Gray100ItalicRegular1 = TextStyle(
    fontSize: 20,
    fontFamily: 'Lora',
    fontStyle: FontStyle.italic,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.gray,
    height: 1,
  );
  static TextStyle loraFont16Gray100ItalicRegular1 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lora',
    fontStyle: FontStyle.italic,
    fontWeight: FontWeightHelper.regular,
    color: AppColor.gray,
    height: 1,
  );
  static TextStyle systemFont15White100RegularLight1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightHelper.light,
    color: AppColor.white,
    height: 1,
  );
}
