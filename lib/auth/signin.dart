import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  void signin() async
  {
    String email = emailcontroller.text;
    String pass = passwordcontroller.text;
    String error = "";

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: pass
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error='Wrong password provided for that user.';
      }
    }

    if(error!="")
    {
      showDialog
      (
        context: context, 
        builder: (ontext)=>AlertDialog
        (
          title: Text
          (
            "Error"
          ),
          content: SingleChildScrollView
          (
            child: ListBody
            (
              children:
              [
                Text(error),
                Text("Please try again!"),
              ],
            ),
          ),
          actions:
          [
            TextButton
            (
              child: Text
              (
                "Ok"
              ),
              onPressed:() 
              {
                Navigator.of(context).pop();
              },
            ),
          ],
        )
      );
    }
    final user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: Center
      (
        child: Padding
        (
          padding: EdgeInsets.only(top: 100),
          child: SizedBox
          (
            width: 350,
            child: Column
            (
              children:
              [
                Text
                (
                  "Sign in",
                  style: TextStyle
                  (
                    fontSize: 24
                  ),
                ),
                Padding
                (
                  padding: EdgeInsets.only
                  (
                    top: 25,
                    bottom: 25
                  ),
                  child: TextFormField
                  (
                    controller: emailcontroller,
                    decoration: InputDecoration
                    (
                      icon: Icon(Icons.email_outlined),
                      labelText: "Email"
                    ),
                  ),
                ),
                Padding
                (
                  padding: EdgeInsets.only
                  (
                    top: 25,
                    bottom: 25
                  ),
                  child: TextFormField
                  (
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration
                    (
                      icon: Icon(Icons.key),
                      labelText: "Password",
                    ),
                  ),
                ),
                Padding
                (
                  padding: EdgeInsets.only
                  (
                    top: 25,
                    bottom: 25
                  ),
                  child: ElevatedButton
                  (
                    child: Text
                    (
                      "Sign in"
                    ),
                    onPressed: signin,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}