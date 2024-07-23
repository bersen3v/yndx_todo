import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';

const textTheme = TextTheme();

final themeData = ThemeData(
  fontFamily: 'sfpro',
  useMaterial3: true,
  textTheme: textTheme,
);

final darkTheme = themeData.copyWith(
  colorScheme: const ColorScheme.dark(
    secondary: Styles.white,
    onSecondary: Styles.grey06,
  ),
  scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
);

final lightTheme = themeData.copyWith(
  colorScheme: const ColorScheme.light(
    secondary: Styles.black,
    onSecondary: Styles.grey,
  ),
  scaffoldBackgroundColor: Styles.white,
);
