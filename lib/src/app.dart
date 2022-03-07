// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqllite/src/providers/theme_provider.dart';
import 'package:sqllite/src/screens/notes_screen.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => ThemeProvider()),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NotesScreenView(),
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: ThemeMode.system,
          
        );
      },
    );
  }
}
