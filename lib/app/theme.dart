import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rotten_papaya/app/config/app_config.dart';
import 'package:rotten_papaya/app/utils/extensions/text_style_extensions.dart';

/// 100% - Max. For example, error texts.
const opacityMax = 1.0;

/// 87% - High Emphasis. Default for most texts.
const opacityHigh = 0.87;

/// 60% - Medium Emphasis. For example, hint texts.
const opacityMed = 0.60;

/// 38% - Low Emphasis. For example, to indicate disabled or for icons in general.
const opacityLow = 0.38;

/// 12% - Min. Very non-legible, generally not for texts.
const opacityMin = 0.12;

ThemeData get appTheme {
  final colorScheme = ColorScheme(
    primary: Color(AppConfig.primaryColor),
    primaryVariant: Color(AppConfig.primaryVariantColor),
    secondary: Color(AppConfig.secondaryColor),
    secondaryVariant: Color(AppConfig.secondaryVariantColor),
    background: Color(AppConfig.backgroundColor),
    surface: Color(AppConfig.surfaceColor),
    error: Color(AppConfig.errorColor),
    onPrimary: Color(AppConfig.onPrimaryColor),
    onSecondary: Color(AppConfig.onSecondaryColor),
    onBackground: Color(AppConfig.onBackgroundColor),
    onSurface: Color(AppConfig.onSurfaceColor),
    onError: Color(AppConfig.onErrorColor),
    brightness: AppConfig.brightness,
  );

  final textTheme = GoogleFonts.getTextTheme(
    AppConfig.fontFamily,
    TextTheme(
      headline3: TextStyle(
        fontSize: AppConfig.headline3.fontSize,
        fontWeight: AppConfig.headline3.fontWeight,
        letterSpacing: AppConfig.headline3.letterSpacing,
        color: colorScheme.onBackground,
      ),
      headline4: TextStyle(
        fontSize: AppConfig.headline4.fontSize,
        fontWeight: AppConfig.headline4.fontWeight,
        letterSpacing: AppConfig.headline4.letterSpacing,
        color: colorScheme.onBackground,
      ),
      headline5: TextStyle(
        fontSize: AppConfig.headline5.fontSize,
        fontWeight: AppConfig.headline5.fontWeight,
        letterSpacing: AppConfig.headline5.letterSpacing,
        color: colorScheme.onBackground,
      ),
      headline6: TextStyle(
        fontSize: AppConfig.headline6.fontSize,
        fontWeight: AppConfig.headline6.fontWeight,
        letterSpacing: AppConfig.headline6.letterSpacing,
        color: colorScheme.onBackground,
      ),
      subtitle1: TextStyle(
        fontSize: AppConfig.subtitle1.fontSize,
        fontWeight: AppConfig.subtitle1.fontWeight,
        letterSpacing: AppConfig.subtitle1.letterSpacing,
        color: colorScheme.onBackground,
      ),
      subtitle2: TextStyle(
        fontSize: AppConfig.subtitle2.fontSize,
        fontWeight: AppConfig.subtitle2.fontWeight,
        letterSpacing: AppConfig.subtitle2.letterSpacing,
        color: colorScheme.onBackground,
      ),
      bodyText1: TextStyle(
        fontSize: AppConfig.bodyText1.fontSize,
        fontWeight: AppConfig.bodyText1.fontWeight,
        letterSpacing: AppConfig.bodyText1.letterSpacing,
        color: colorScheme.onBackground,
      ),
      bodyText2: TextStyle(
        fontSize: AppConfig.bodyText2.fontSize,
        fontWeight: AppConfig.bodyText2.fontWeight,
        letterSpacing: AppConfig.bodyText2.letterSpacing,
        color: colorScheme.onBackground,
      ),
      caption: TextStyle(
        fontSize: AppConfig.caption.fontSize,
        fontWeight: AppConfig.caption.fontWeight,
        letterSpacing: AppConfig.caption.letterSpacing,
        color: colorScheme.onBackground,
      ),
      button: TextStyle(
        fontSize: AppConfig.button.fontSize,
        fontWeight: AppConfig.button.fontWeight,
        letterSpacing: AppConfig.button.letterSpacing,
        color: colorScheme.onBackground,
      ),
      overline: TextStyle(
        fontSize: AppConfig.overline.fontSize,
        fontWeight: AppConfig.overline.fontWeight,
        letterSpacing: AppConfig.overline.letterSpacing,
        color: colorScheme.onBackground,
      ),
    ),
  );

  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
  );
}

ColorScheme getColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

TextTheme getTextTheme(BuildContext context) => Theme.of(context).textTheme;

String getFontFamily() => AppConfig.fontFamily;

/// See [Primary color] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorPrimary(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).primary.withOpacity(opacity);
}

/// See [Primary color] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorPrimaryVariant(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).primaryVariant.withOpacity(opacity);
}

/// See [Secondary color] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorSecondary(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).secondary.withOpacity(opacity);
}

/// See [Secondary color] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorSecondaryVariant(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).secondaryVariant.withOpacity(opacity);
}

/// See [Surface, background, and error colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorBackground(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).background.withOpacity(opacity);
}

/// See [Surface, background, and error colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorSurface(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).surface.withOpacity(opacity);
}

/// See [Surface, background, and error colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
/// to know when to apply
Color getColorError(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).error.withOpacity(opacity);
}

/// Returns the generic disabled color. Generally there are 2 ways to color a
/// disabled widget or text:
///
/// 1. Use this method to get the generic disabledColor (e.g. white38 or black38)
///
/// 2. Make the widget or text opacity to OpacityLevel.LOW
///
/// Depending on which scenario you want to use
Color getColorDisabled(BuildContext context) {
  return Theme.of(context).disabledColor;
}

/// Generally this should only used for iconography, for text use the
/// getXXTextStyle() instead and pass in the appropriate onType or overrideColor
Color getColorOnPrimary(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).onPrimary.withOpacity(opacity);
}

/// Generally this should only used for iconography, for text use the
/// getXXTextStyle() instead and pass in the appropriate onType or overrideColor
Color getColorOnSecondary(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).onSecondary.withOpacity(opacity);
}

/// Generally this should only used for iconography, for text use the
/// getXXTextStyle() instead and pass in the appropriate onType or overrideColor
Color getColorOnBackground(
  BuildContext context, {
  double opacity = opacityHigh,
}) {
  return getColorScheme(context).onBackground.withOpacity(opacity);
}

/// Generally this should only used for iconography, for text use the
/// getXXTextStyle() instead and pass in the appropriate onType or overrideColor
Color getColorOnSurface(
  BuildContext context, {
  double opacity = opacityHigh,
}) {
  return getColorScheme(context).onSurface.withOpacity(opacity);
}

/// Generally this should only used for iconography, for text use the
/// getXXTextStyle() instead and pass in the appropriate onType or overrideColor
Color getColorOnError(
  BuildContext context, {
  double opacity = opacityMax,
}) {
  return getColorScheme(context).onError.withOpacity(opacity);
}

/// See [Headlines] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleHeadline1(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .headline1
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Headlines] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleHeadline2(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .headline2
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Headlines] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleHeadline3(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .headline3
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Headlines] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation
TextStyle getTextStyleHeadline4(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .headline4
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Headlines] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleHeadline5(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .headline5
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Headlines] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For example, the [AppBar]
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleHeadline6(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .headline6
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Subtitles] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleSubtitle1(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .subtitle1
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Subtitles] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleSubtitle2(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .subtitle2
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Body] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleBodyText1(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .bodyText1
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Body] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleBodyText2(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .bodyText2
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Caption and overline] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// To annotate imagery or introduce a headline
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleCaption(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .caption
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Caption and overline] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// To annotate imagery or introduce a headline
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleOverline(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .overline
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));

/// See [Button] section in
/// [https://material.io/design/typography/the-type-system.html#applying-the-type-scale]
/// to know when to apply
///
/// Applies to FlatButton, OutlinedButton, TextButton and even tabs, dialogs and cards
///
/// For specifiying [onType] see [Typography and iconography colors] section in
/// [https://material.io/design/color/the-color-system.html#color-theme-creation]
TextStyle getTextStyleButton(
  BuildContext context, {
  Color color,
  FontWeight overrideFontWeight,
}) =>
    getTextTheme(context)
        .button
        .applyGoogleFontWeight(overrideFontWeight)
        .applyColor(color ?? getColorOnBackground(context));
