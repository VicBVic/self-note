// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/robertstore.dart';

class SignupPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

Future<bool> signup(var email, var pass, var confpass, var context,var gemail,var name) async {
  String error = "";

  if (pass == confpass) {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Robertstore().addUser(gemail, name, credential.user!.uid.toString());
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
    return false;
  }
  return true;
}

class _SignupPageState extends State<SignupPage> {
  
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController confirmpasswordcontroller = new TextEditingController();
  final TextEditingController numecontroller = new TextEditingController();
  final TextEditingController gemailcontroller = new TextEditingController();

  String emailerror="";
  String passerror="";
  String confpasserror="";
  String gemailerror="";
  String nameerror="";

  @override
  Widget build(BuildContext context) {
    emailcontroller.addListener(() {
      setState(() {
        emailerror=emailcontroller.text==""?"This field can't be empty":"";
      });
    },);
    passwordcontroller.addListener(() {
      setState(() {
        passerror=passwordcontroller.text==""?"This field can't be empty":"";
      });
    },);
    confirmpasswordcontroller.addListener(() {
      setState(() {
        confpasserror=confirmpasswordcontroller.text==""?"This field can't be empty":"";
      });
    },);
    numecontroller.addListener(() {
      setState(() {
        nameerror=numecontroller.text==""?"This field can't be empty":"";
      });
    },);
    gemailcontroller.addListener(() {
      setState(() {
        gemailerror=gemailcontroller.text==""?"This field can't be empty":"";
      });
    },);
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
                  controller: numecontroller,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), 
                      labelText: "Name",
                      errorText: nameerror,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined), 
                      labelText: "Email",
                      errorText: emailerror,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: gemailcontroller,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email_outlined), 
                      labelText: "Guardian email",
                      errorText: gemailerror,
                      ),
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
                    errorText: passerror,
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
                    errorText: confpasserror,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: ElevatedButton(
                  child: Text("Sign up"),
                  onPressed: () => signup(
                          emailcontroller.text,
                          passwordcontroller.text,
                          confirmpasswordcontroller.text,
                          context,
                          gemailcontroller.text,
                          numecontroller.text
                          )
                      .then((value) {
                    if (value == true) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
