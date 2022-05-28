import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/paper_editors/paper_good/paper_good.dart';
import 'package:itec20222/widgets/wavy_container.dart';

final user = FirebaseAuth.instance.currentUser;

class DesktopHomeScreen extends StatefulWidget {
  DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  bool userIsLoggedIn = user != null;
  bool isBad = true;
  StreamController streamController = StreamController();

  @override
  Widget build(BuildContext context) {
    Stream stream = streamController.stream;
    stream.listen((value) {
      print('Value from controller: $value');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selfnote',
          style:
              Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30.0),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              if (!userIsLoggedIn) {
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
                  //TODO: metoda de signout
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
            firstChild: PaperBad(),
            secondChild: PaperGood(),
            crossFadeState:
                isBad ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ],
      ),
    );
  }
}
