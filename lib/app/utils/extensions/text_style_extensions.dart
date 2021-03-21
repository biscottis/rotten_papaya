import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rotten_papaya/app/theme.dart';

extension TextStyleExtension on TextStyle {
  /// This is to fix a bug with the GoogleFonts library, the fontWeight is
  /// actually resolved from the fontFamily, so manually changing the fontWeight
  /// doesn't work
  /// See: [https://github.com/material-foundation/google-fonts-flutter/issues/35]
  TextStyle applyGoogleFontWeight(FontWeight overrideFontWeight) {
    if (overrideFontWeight == null || this.fontWeight == overrideFontWeight) {
      return this;
    }

    final newFontWeightFamily =
        GoogleFonts.getFont(getFontFamily(), fontWeight: overrideFontWeight)
            .fontFamily;

    return copyWith(
        fontFamily: newFontWeightFamily, fontWeight: overrideFontWeight);
  }

  TextStyle applyColor(Color color) {
    return copyWith(color: color);
  }
}
