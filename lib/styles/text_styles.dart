import 'package:flutter/material.dart';
import 'package:kenari_app/styles/color_styles.dart';

class XSTextStyles {
  static TextStyle regular() {
    return TextStyle(
      color: TextColorStyles.textSecondary(),
      fontSize: 10.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle medium() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 10.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }
}

class STextStyles {
  static TextStyle regular() {
    return TextStyle(
      color: TextColorStyles.textSecondary(),
      fontSize: 12.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle medium() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 12.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }
}

class MTextStyles {
  static TextStyle regular() {
    return TextStyle(
      color: TextColorStyles.textSecondary(),
      fontSize: 14.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle medium() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 14.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }
}

class LTextStyles {
  static TextStyle regular() {
    return TextStyle(
      color: TextColorStyles.textSecondary(),
      fontSize: 16.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle medium() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 16.0,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    );
  }
}

class HeadingTextStyles {
  static TextStyle headingS() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 20.0,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle headingM() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 28.0,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle headingL() {
    return TextStyle(
      color: TextColorStyles.textPrimary(),
      fontSize: 36.0,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
    );
  }
}