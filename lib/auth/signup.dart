// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController confirmpasswordcontroller = new TextEditingController();

  void signup() async {
    String email = emailcontroller.text;
    String pass = passwordcontroller.text;
    String confpass = confirmpasswordcontroller.text;
    String error = "";

    if (pass == confpass) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          error = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          error = 'The account already exists for that email.';
        }
      } catch (e) {
        error = e.toString();
      }
    } else {
      error = "The passwords do not match!";
    }

    if (error != "") {
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
    } else {
      //mergem mai departe
    }
  }

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
                "Sign up",
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
                child: TextFormField(
                  controller: confirmpasswordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.key),
                    labelText: "Confirm password",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: ElevatedButton(
                  child: Text("Sign up"),
                  onPressed: signup,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
