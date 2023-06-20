import 'package:flutter/material.dart';

final ThemeData defaultTheme = _buildCustomTheme();

class MyColors {
  static const Color darkBlue   = Color(0xFF346186);
  static const Color calender   = Color(0xfffadcd4);
  static const Color lightRed   = Color(0xFFE78771);
  static const Color lightBlue  = Color(0xFF227A92);
  static const Color lightGreen = Color(0xFF83CBC8);
  static const Color green      = Color(0xFF88cdca);
  static const Color darkGreen  = Color(0xFF267d94);
  static const Color lightWhite = Color(0xFFede7f4);
  static const Color darkGray   = Color(0xFF2D2D2D);
  static const Color lightGray  = Color(0xFFA1A1A1);

  static const Color landing1   = Color(0xFF76b0de);
  static const Color landing2   = Color(0xFF83cbc8);
  static const Color landing3   = Color(0xfff1bdb2);
}

ColorScheme myColorScheme = const ColorScheme(
  primary: MyColors.lightBlue,
  primaryVariant: MyColors.darkBlue,
  secondary: MyColors.landing1,
  secondaryVariant: MyColors.lightRed,
  surface: Colors.white,
  background: Colors.white,
  error: MyColors.lightRed,
  onPrimary: Colors.white,
  onSecondary: MyColors.lightRed,
  onSurface: Colors.black54,
  onBackground: Colors.black54,
  onError: Colors.black54,
  brightness: Brightness.light,
);

ThemeData _buildCustomTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: myColorScheme,
    toggleableActiveColor: MyColors.lightBlue,
    accentColor: MyColors.lightRed,
    primaryColor: MyColors.lightBlue,
    buttonColor: MyColors.lightBlue,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    errorColor: MyColors.lightGreen,
    buttonTheme: ButtonThemeData(
      colorScheme: myColorScheme,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
      )


    ),
    textTheme: _buildCustomTextTheme(base.textTheme),
    primaryTextTheme: _buildCustomTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildCustomTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildCustomTextTheme(TextTheme base) {
  return base
      .copyWith(
    caption: base.caption?.copyWith(
      color: Colors.black
    ),
    button: base.button?.copyWith(
      letterSpacing: 0.7
    )
  ).apply(
    fontFamily: 'Raleway',
  );
}

