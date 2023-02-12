import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cookies.dart';

class HomescreenDrawer extends StatelessWidget {
  final User? user;
  final Future<void> Function() logout;
  const HomescreenDrawer({super.key, required this.user, required this.logout});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: (user == null)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Sign up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text('Sign in'),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('Memories'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/memories');
                  },
                ),
                TextButton(onPressed: logout, child: const Text('Sign out')),
              ],
            ),
    );
  }
}
