import 'dart:ui';

import 'package:flutter/material.dart';

class AppConfig {
  // Material Colors
  static const primaryColor = int.fromEnvironment(
    'primaryColor',
    defaultValue: 0xFFF44336,
  );
  static const primaryVariantColor = int.fromEnvironment(
    'primaryVariantColor',
    defaultValue: 0xFFD32F2F,
  );
  static const secondaryColor = int.fromEnvironment(
    'secondaryColor',
    defaultValue: 0xFFFF9800,
  );
  static const secondaryVariantColor = int.fromEnvironment(
    'secondaryVariantColor',
    defaultValue: 0xFFFFCDD2,
  );
  static const backgroundColor = int.fromEnvironment(
    'backgroundColor',
    defaultValue: 0xFFFFFFFF,
  );
  static const surfaceColor = int.fromEnvironment(
    'surfaceColor',
    defaultValue: 0xFFFFFFFF,
  );
  static const errorColor = int.fromEnvironment(
    'errorColor',
    defaultValue: 0xFFB00020,
  );
  static const onPrimaryColor = int.fromEnvironment(
    'onPrimaryColor',
    defaultValue: 0xFFFFFFFF,
  );
  static const onSecondaryColor = int.fromEnvironment(
    'onSecondaryColor',
    defaultValue: 0xFFFFFFFF,
  );
  static const onBackgroundColor = int.fromEnvironment(
    'onBackgroundColor',
    defaultValue: 0xFF000000,
  );
  static const onSurfaceColor = int.fromEnvironment(
    'onSurfaceColor',
    defaultValue: 0xFF000000,
  );
  static const onErrorColor = int.fromEnvironment(
    'onErrorColor',
    defaultValue: 0xFFFFFFFF,
  );
  static const _brightness = String.fromEnvironment(
    'brightness',
    defaultValue: 'light',
  );
  static Brightness get brightness => _toBrightness(_brightness);

  static const fontFamily = String.fromEnvironment(
    'fontFamily',
    defaultValue: 'Montserrat',
  );

  static const _headline1 =
      String.fromEnvironment('headline1', defaultValue: '97.0|300|-1.5');
  static AppConfigFontSetting get headline1 => parseFontSettings(_headline1);

  static const _headline2 =
      String.fromEnvironment('headline2', defaultValue: '61.0|300|-0.5');
  static AppConfigFontSetting get headline2 => parseFontSettings(_headline2);

  static const _headline3 =
      String.fromEnvironment('headline3', defaultValue: '48.0|400|0.0');
  static AppConfigFontSetting get headline3 => parseFontSettings(_headline3);

  static const _headline4 =
      String.fromEnvironment('headline4', defaultValue: '34.0|400|0.25');
  static AppConfigFontSetting get headline4 => parseFontSettings(_headline4);

  static const _headline5 =
      String.fromEnvironment('headline5', defaultValue: '24.0|400|0.0');
  static AppConfigFontSetting get headline5 => parseFontSettings(_headline5);

  static const _headline6 =
      String.fromEnvironment('headline6', defaultValue: '20.0|500|0.15');
  static AppConfigFontSetting get headline6 => parseFontSettings(_headline6);

  static const _subtitle1 =
      String.fromEnvironment('subtitle1', defaultValue: '16.0|400|0.15');
  static AppConfigFontSetting get subtitle1 => parseFontSettings(_subtitle1);

  static const _subtitle2 =
      String.fromEnvironment('subtitle2', defaultValue: '14.0|500|0.1');
  static AppConfigFontSetting get subtitle2 => parseFontSettings(_subtitle2);

  static const _bodyText1 =
      String.fromEnvironment('bodyText1', defaultValue: '16.0|400|0.5');
  static AppConfigFontSetting get bodyText1 => parseFontSettings(_bodyText1);

  static const _bodyText2 =
      String.fromEnvironment('bodyText2', defaultValue: '14.0|400|0.25');
  static AppConfigFontSetting get bodyText2 => parseFontSettings(_bodyText2);

  static const _button =
      String.fromEnvironment('button', defaultValue: '14.0|600|1.25');
  static AppConfigFontSetting get button => parseFontSettings(_button);

  static const _caption =
      String.fromEnvironment('caption', defaultValue: '12.0|400|0.4');
  static AppConfigFontSetting get caption => parseFontSettings(_caption);

  static const _overline =
      String.fromEnvironment('overline', defaultValue: '10.0|400|1.5');
  static AppConfigFontSetting get overline => parseFontSettings(_overline);
}

FontWeight _toFontWeight(int weight) {
  switch (weight) {
    case 100:
      return FontWeight.w100;
    case 200:
      return FontWeight.w200;
    case 300:
      return FontWeight.w300;
    case 400:
      return FontWeight.w400;
    case 500:
      return FontWeight.w500;
    case 600:
      return FontWeight.w600;
    case 700:
      return FontWeight.w700;
    case 800:
      return FontWeight.w800;
    case 900:
      return FontWeight.w900;
    default:
      throw ArgumentError('Unknown fontWeight: $weight');
  }
}

Brightness _toBrightness(String brightness) {
  switch (brightness) {
    case 'light':
      return Brightness.light;
    case 'dark':
      return Brightness.dark;
    default:
      throw ArgumentError('Unknown brightness: $brightness');
  }
}

AppConfigFontSetting parseFontSettings(String delimitedFontSettings) {
  if (delimitedFontSettings == null || delimitedFontSettings.isEmpty) {
    return null;
  }

  final splitSettings = delimitedFontSettings.split('|');
  final expectedLength = 3;
  if (splitSettings.length != expectedLength) {
    throw ArgumentError(
        'Invalid app_config settings. Expected $expectedLength for fontSize, fontWeight and letterSpacing');
  }

  final fontSize = double.parse(splitSettings[0]);
  final fontWeight = _toFontWeight(int.parse(splitSettings[1]));
  final letterSpacing = double.parse(splitSettings[2]);

  return AppConfigFontSetting(fontSize, fontWeight, letterSpacing);
}

class AppConfigFontSetting {
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;

  AppConfigFontSetting(this.fontSize, this.fontWeight, this.letterSpacing);
}
