import 'package:flutter/material.dart';
import 'package:itec20222/auth/signup.dart';
import 'package:itec20222/screens/desktop_homescreen.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/myhomepage.dart';
import 'package:itec20222/auth/signin.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

const colorScheme = ColorScheme(
  primary: Colors.amber,
  secondary: Color.fromARGB(255, 155, 155, 155),
  onPrimary: Colors.black87,
  onSecondary: Colors.black,
  background: Colors.black,
  onBackground: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  surface: Color.fromARGB(255, 14, 13, 15),
  onSurface: Colors.white70,
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/papers',
      routes: {
        '/papers': (context) => MyHomePage(
              title: 'Bad thoughts paper',
            ),
        '/signin': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
      },
      title: 'SelfNote',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        //brightness: Brightness.dark,
        /* dark theme settings */
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorScheme: colorScheme,
        fontFamily: "TiroDevanagariHindi",
        textTheme: const TextTheme(
          headline2: TextStyle(
              //color: Colors.green,
              ),
        ),
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
