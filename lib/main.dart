import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/myhomepage.dart';
import 'package:itec20222/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

const colorScheme = ColorScheme(
  primary: Color.fromARGB(255, 255, 174, 0),
  secondary: Color.fromARGB(255, 155, 155, 155),
  onPrimary: Colors.black87,
  onSecondary: Colors.white70,
  background: Colors.black,
  onBackground: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  surface: Color.fromARGB(255, 0, 0, 0),
  onSurface: Colors.white70,
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        //brightness: Brightness.dark,
        /* dark theme settings */
        scaffoldBackgroundColor: Color.fromARGB(255, 5, 5, 20),
        colorScheme: colorScheme,
        navigationRailTheme: NavigationRailThemeData(
          selectedIconTheme: IconThemeData(
            color: Colors.blue,
          ),
          selectedLabelTextStyle: TextStyle(
            color: Color.fromARGB(255, 0, 195, 255),
            fontSize: 13,
            letterSpacing: 0.8,
            decoration: TextDecoration.underline,
            decorationThickness: 2.0,
          ),
        ),
        fontFamily: "TiroDevanagariHindi",
        textTheme: TextTheme(
          headline2: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
