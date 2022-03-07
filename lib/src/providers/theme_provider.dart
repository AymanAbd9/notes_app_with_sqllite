import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  // bool get isDarkMode {
  //   if (themeMode == ThemeMode.system) {
  //     final brightness = SchedulerBinding.instance!.window.platformBrightness;
  //     return brightness == Brightness.dark;
  //   } else {
  //     return themeMode == ThemeMode.dark;
  //   }
  // }

  // void toggleTheme(bool isOn) {
  //   themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  //   notifyListeners();
  // }
}

class MyThemes {
  static final darkTheme = ThemeData.dark().copyWith(
      // primaryColor: Colors.black,
      appBarTheme: const AppBarTheme(color: Colors.black87),
      backgroundColor: Colors.grey,
      scaffoldBackgroundColor: Colors.grey,
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.teal),
    );

  static final lightTheme = ThemeData(
      primaryColor: Colors.lightBlue,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.grey[100],
      textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
    );
}