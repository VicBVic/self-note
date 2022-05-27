import 'package:flutter/material.dart';
import 'package:itec20222/screens/desktop_homescreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DesktopHomeScreen(); //aici o sa fie un if daca e desktop sau mobile
  }
}
