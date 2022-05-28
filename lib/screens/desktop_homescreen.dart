import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/paper_editors/paper_good/paper_good.dart';
import 'package:itec20222/widgets/wavy_container.dart';

class DesktopHomeScreen extends StatefulWidget {
  DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  bool userIsLoggedIn = false; //TODO: verifica robert
  bool isBad = false;

  @override
  Widget build(BuildContext context) {
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
                    child: Text('Log in'),
                    onTap: () => Navigator.pushNamed(context, '/login'),
                  ),
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
          isBad ? PaperBad() : PaperGood(),
        ],
      ),
    );
  }
}
