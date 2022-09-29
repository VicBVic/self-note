import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/auth/signin.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/screens/good_memories.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/paper_editors/paper_good/paper_good.dart';
import 'package:itec20222/widgets/cookies.dart';
import 'package:itec20222/widgets/wavy_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

//var user = FirebaseAuth.instance.currentUser;

class DesktopHomeScreen extends StatefulWidget {
  String title;
  DesktopHomeScreen({required this.title, Key? key}) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  //bool userIsLoggedIn = user != null;
  bool isBad = true;
  String name="";

  void autoLogIn() async {
    final cookie = Cookies();
    final loginInfo = await cookie.getStoredLoginInfo();
    if (loginInfo != null) {
      print("here ${loginInfo.first}  ${loginInfo.last}");
      signin(loginInfo.first, loginInfo.last, context).then((value) {
        print("finished $value");
        if (value == true) {
          setState(() {
            print("bossulica fa refresh");
          });
        }
      });
    }
  }

  var user = FirebaseAuth.instance.currentUser;

  void logOut() async {
    FirebaseAuth.instance.signOut();
    Cookies().deleteInfo();
    setState(() {});
  }

  void getName() async
  {
    await Robertstore().getName(user!.uid.toString()).then((value) => {
        name=value
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle b1 =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22.0);
    user = FirebaseAuth.instance.currentUser;
    if (user == null) 
    {
      autoLogIn();
    }
    if(user != null)getName();
    return Scaffold(
      drawer: Drawer(
        child: (user == null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text('Sign up'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: Text('Sign in'),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    child: Text('Memories'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/memories');
                    },
                  ),
                  TextButton(onPressed: logOut, child: Text('Sign out')),
                ],
              ),
      ),
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30.0),
        ),
        actions: [
          Text(
            user == null
                ? 'You are not logged in'
                : 'You are logged in, ${name}',
            style: b1,
          ),
        ],
      ),
      body: ListView(
        children: [
          AnimatedCrossFade(
            duration: const Duration(seconds: 5),
            firstChild: PaperGood(),
            secondChild: PaperBad(
              onBurned: () {
                setState(() {
                  isBad = false;
                });
              },
            ),
            crossFadeState:
                isBad ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
