import 'package:flutter/material.dart';

class ThemeApp {
  const ThemeApp._();

  static const fontName = null; //'Poppins';
  static const textColors = Color(0xffFFFFFF);
  static const boderColor = Color(0xffF6F6F6);
  static const buttonTextColor = Color(0xff7190FF);
  static const appYelowColor = Color(0xffFFC371);
  static const appGrayColor = Color(0xffF2F2F2);
  static const gradientButtonAction = [Color(0xffFF5F6D), Color(0xffFFC371)];
  static const gradientTabIndicator = [Color(0xffFFAFBD), Color(0xffFFC3A0)];
  static const appRedColor = Color(0xffFF5F6D);
  static final appTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xff27AE60),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: fontName,
    textTheme: textTheme,
    cardColor: Colors.white,
    unselectedWidgetColor: const Color(0xffF1F1F1),
  );

  static TextTheme textTheme = const TextTheme(
      displayLarge: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 14,
          fontWeight: FontWeight.normal),
      displayMedium: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 45,
          fontWeight: FontWeight.normal),
      displaySmall: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 36,
          fontWeight: FontWeight.normal),
      headlineLarge: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 32,
          fontWeight: FontWeight.normal),
      headlineMedium: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 28,
          fontWeight: FontWeight.normal),
      headlineSmall: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 24,
          fontWeight: FontWeight.normal),
      titleLarge: TextStyle(
          fontFamily: fontName,
          color: textColors,
          fontSize: 22,
          fontWeight: FontWeight.normal),
      titleMedium: TextStyle(
        fontFamily: fontName,
        color: textColors,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      titleSmall: TextStyle(
        fontFamily: fontName,
        color: textColors,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: fontName,
        color: textColors,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        fontFamily: fontName,
        color: textColors,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontFamily: fontName,
        color: textColors,
        fontSize: 11,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
          fontFamily: fontName,
          fontSize: 16,
          color: textColors,
          fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(
          fontFamily: fontName,
          fontSize: 14,
          color: textColors,
          fontWeight: FontWeight.normal),
      bodySmall: TextStyle(
        fontFamily: fontName,
        color: textColors,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ));
}
