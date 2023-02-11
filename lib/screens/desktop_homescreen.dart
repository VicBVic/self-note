import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itec20222/auth/signin.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paper_bad.dart';
import 'package:itec20222/screens/paper_editors/paper_good/paper_good.dart';
import 'package:itec20222/widgets/cookies.dart';

//var user = FirebaseAuth.instance.currentUser;

final StateProvider<User?> user = StateProvider((ref) => null);
final StateProvider<String?> name = StateProvider((ref) => null);

class DesktopHomeScreen extends ConsumerStatefulWidget {
  String title;
  DesktopHomeScreen({required this.title, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends ConsumerState<DesktopHomeScreen> {
  //bool userIsLoggedIn = user != null;
  bool isBad = true;

  void autoLogIn() async {
    final cookie = Cookies();
    final loginInfo = await cookie.getStoredLoginInfo();
    if (loginInfo != null) {
      //print("here ${loginInfo.first}  ${loginInfo.last}");
      // signin(loginInfo.first, loginInfo.last, context).then((value) {
      //   //print("finished $value");
      //   if (value == true) {
      //     setState(() {
      //       //print("bossulica fa refresh");
      //     });
      //   }
      // });
    }
  }

  void logOut() async {
    FirebaseAuth.instance.signOut();
    Cookies().deleteInfo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      ref.read(user.notifier).state = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? u = ref.watch(user);

    ref.listen<User?>(user, (previous, next) async {
      if (next != null) {
        ref.read(name.notifier).state =
            await Robertstore.instance.getName(next.uid);
      }
    });

    TextStyle b1 =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22.0);

    if (u == null) {
      //print("yesofcors");
      autoLogIn();
    }

    return Scaffold(
      drawer: Drawer(
        child: (u == null)
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
                  TextButton(onPressed: logOut, child: const Text('Sign out')),
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
            u == null
                ? 'You are not logged in'
                : 'You are logged in ${ref.watch(name) != null ? ", ${ref.watch(name)}" : ""}',
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
