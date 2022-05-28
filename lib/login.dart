import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninPage extends StatefulWidget {

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String text = "login";
  void login() async
  {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "r.acatrienei2005@gmail.com",
        password: "dcnjhbd321esd",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          text='The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          text='The account already exists for that email.';
        });
      }
    } catch (e) {
      setState(() {
        text=e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center
    (
      child: Column
      (
        children: 
        [
          ElevatedButton
          (
            onPressed: login, 
            child: Text(text) ,
          ),
          ElevatedButton
          (
            onPressed: login, 
            child: Text("Sign in with google"),
          ),
        ],
      ),
    );
  }
}