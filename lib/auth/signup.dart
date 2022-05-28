import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                  "Sign up",
                  style: TextStyle
                  (
                    fontSize: 24
                  ),
                ),
                Padding
                (
                  padding: EdgeInsets.only(top: 25,bottom: 25),
                  child: TextField
                  (

                  ),
                ),
                Padding
                (
                  padding: EdgeInsets.only(top: 25,bottom: 25),
                  child: TextFormField
                  (

                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}