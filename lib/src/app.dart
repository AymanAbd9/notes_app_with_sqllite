// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sqllite/src/screens/notes_screen.dart';

class AppView extends StatelessWidget {
  const AppView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreenView(),
    );
  }
}