import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/robertstore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

Future<bool> signup(String fname, String lname, String email, String pass,
    String confpass, var context) async {
  String error = "";

  if (fname == "" ||
      lname == "" ||
      email == "" ||
      pass == "" ||
      confpass == "") {
    error = "You have not completed all fields";
  }

  if (error == "") {
    if (pass == confpass) {
      try {
        //final credential =
        var u = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );
        await Robertstore.instance.createUser(u.user!.uid, fname, lname);
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
  return true;
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

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
                "Sign up",
                style: TextStyle(fontSize: 24),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: fnamecontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), labelText: "First name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: TextFormField(
                  controller: lnamecontroller,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), labelText: "Last name"),
                ),
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
                child: TextFormField(
                  controller: confirmpasswordcontroller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.key),
                    labelText: "Confirm password",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: ElevatedButton(
                  child: const Text("Sign up"),
                  onPressed: () => signup(
                          fnamecontroller.text,
                          lnamecontroller.text,
                          emailcontroller.text,
                          passwordcontroller.text,
                          confirmpasswordcontroller.text,
                          context)
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
