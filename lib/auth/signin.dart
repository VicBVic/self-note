import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/widgets/cookies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

Future<bool> signin(String email, String pass, var context) async {
  //print("signin here $email $pass");

  String error = "";

  try {
    //final credential =
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);

    var user = FirebaseAuth.instance.currentUser;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', user!.uid);
  } on FirebaseAuthException catch (e) {
    error = e.code;
  }

  if (error != "") {
    showDialog(
        context: context,
        builder: (ontext) => AlertDialog(
              title: const Text("Error"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(error),
                    const Text("Please try again!"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
    return false;
  }
  var cookie = Cookies();
  //print("here bossulica");
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
        padding: const EdgeInsets.only(top: 100),
        child: SizedBox(
          width: 350,
          child: Column(
            children: [
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email_outlined), labelText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.key),
                    labelText: "Password",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: ElevatedButton(
                  child: const Text("Sign in"),
                  onPressed: () async {
                    await signin(emailcontroller.text, passwordcontroller.text,
                            context)
                        .then((value) {
                      //print("here");
                      if (value == true) {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (route) => false);
                      }
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
