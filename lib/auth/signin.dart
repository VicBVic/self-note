import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:itec20222/widgets/cookies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

Future<bool> signin(String email, String pass, var context) async {
  print("signin here $email $pass");

  String error = "";

  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);

    var user = FirebaseAuth.instance.currentUser;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', user!.uid);
  } on FirebaseAuthException catch (e) {
    error = e.code;
  }

  if (error != "") {
    print('zyz: ' + error);
    showDialog(
        context: context,
        builder: (ontext) => AlertDialog(
              title: Text("Error"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(error),
                    Text("Please try again!"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
    return false;
  }
  var cookie = Cookies();
  print("here bossulica");
  cookie.setStoredLoginInfo([email, pass]);
  return true;
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: SizedBox(
          width: 350,
          child: Column(
            children: [
              Text(
                "Sign in",
                style: TextStyle(fontSize: 24),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined), labelText: "Email"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.key),
                    labelText: "Password",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: ElevatedButton(
                  child: Text("Sign in"),
                  onPressed: () async {
                    await signin(emailcontroller.text, passwordcontroller.text,
                            context)
                        .then((value) {
                      print("here");
                      if (value == true)
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (route) => false);
                    });
                    //Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
