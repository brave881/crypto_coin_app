import 'package:flutter/material.dart';

final theme = ThemeData(
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black,
  ),
  primaryColor: Colors.blue,
  primarySwatch: Colors.blueGrey,
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      backgroundColor: Colors.blueAccent),
);
