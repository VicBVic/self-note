import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/screens/good_memories.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/paper_editors/paper_good/paper_good.dart';
import 'package:itec20222/widgets/wavy_container.dart';

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
  StreamController streamController = StreamController();

  void gotomem()
  {
    Navigator.pushNamed(context, '/memories');
  }

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
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
            : Center(
                child: TextButton(
                  child: Text('Memories'),
                  onPressed: () {
                    gotomem();
                  },
                ),
              ),
      ),
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30.0),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              if (user == null) {
                return [
                  PopupMenuItem(
                      child: Text('Sign in'),
                      onTap: () {
                        Navigator.pushNamed(context, '/signin');
                      }),
                  PopupMenuItem(
                      child: Text('Register'),
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      }),
                ];
              }
              return [
                PopupMenuItem(
                  child: Text('Log out'),
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                  },
                )
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          AnimatedCrossFade(
            duration: const Duration(seconds: 3),
            firstChild: PaperGood(),
            secondChild: PaperBad(),
            crossFadeState:
                isBad ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }
}
