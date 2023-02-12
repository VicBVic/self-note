import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itec20222/auth/signin.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad_menu.dart';
import 'package:itec20222/screens/paper_editors/paper_good/paper_good_menu.dart';
import 'package:itec20222/widgets/badgood_controller.dart';
import 'package:itec20222/widgets/cookies.dart';
import 'package:itec20222/widgets/homescreen_drawer.dart';

//var user = FirebaseAuth.instance.currentUser;

final StateProvider<User?> userProvider = StateProvider((ref) => null);
final StateProvider<String?> nameProvider = StateProvider((ref) => null);

class DesktopHomeScreen extends ConsumerStatefulWidget {
  String title;
  DesktopHomeScreen({required this.title, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends ConsumerState<DesktopHomeScreen> {
  BadgoodController badgoodController = BadgoodController();

  bool isBad = true;

  Future<void> logOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    badgoodController.addListener(() {
      setState(() {});
    });
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      ref.read(userProvider.notifier).state = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? currentlyLoggedUser = ref.watch(userProvider);

    ref.listen<User?>(userProvider, (previous, next) async {
      if (next != null) {
        ref.read(nameProvider.notifier).state =
            await Robertstore.instance.getName(next.uid);
      } else {
        ref.read(nameProvider.notifier).state = null;
      }
    });

    TextStyle b1 =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22.0);

    return Scaffold(
      drawer: HomescreenDrawer(
        user: currentlyLoggedUser,
        logout: logOut,
      ),
      appBar: AppBar(
        title: Text(
          widget.title,
          style:
              Theme.of(context).textTheme.headline3!.copyWith(fontSize: 30.0),
        ),
        actions: [
          Text(
            currentlyLoggedUser == null
                ? 'You are not logged in'
                : 'You are logged in${ref.watch(nameProvider) != null ? ", ${ref.watch(nameProvider)}" : ""}',
            style: b1,
          ),
        ],
      ),
      body: AnimatedCrossFade(
        duration: const Duration(seconds: 1),
        firstChild: PaperGood(),
        secondChild: PaperBadMenu(
          badgoodController: badgoodController,
        ),
        crossFadeState: badgoodController.isBad
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
      ),
    );
  }
}
