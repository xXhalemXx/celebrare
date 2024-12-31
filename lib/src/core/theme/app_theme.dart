import 'package:celebrare/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.lightShadyWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    shadowColor: AppColor.lightGray,
    elevation: 1, // Set background to
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.shadeTeal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);
