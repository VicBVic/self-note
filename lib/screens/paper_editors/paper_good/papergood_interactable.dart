import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itec20222/consts.dart';
import 'package:itec20222/robertstore.dart';
import 'package:itec20222/screens/paper_editors/paper.dart';
import 'package:itec20222/classes/color_picker_button.dart';
import 'package:painter/painter.dart';

var user = FirebaseAuth.instance.currentUser;

class PaperGoodInteractable extends StatefulWidget {
  TextEditingController thing1 = TextEditingController();
  TextEditingController thing2 = TextEditingController();
  TextEditingController thing3 = TextEditingController();

  final double paperHeight;
  late double padding;
  int happiness = 5;
  PaperGoodInteractable({
    Key? key,
    this.paperHeight = 250,
    required this.padding,
  }) : super(key: key);

  @override
  State<PaperGoodInteractable> createState() => _PaperGoodInteractableState();
}

class _PaperGoodInteractableState extends State<PaperGoodInteractable> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    user = FirebaseAuth.instance.currentUser;
    var b1 = Theme.of(context).textTheme.headline3!.copyWith(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 24);
    var b2 =
        Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black);
    var snackBar = const SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Saved to your memories!'),
    );
    InputDecoration dec = const InputDecoration(
      contentPadding: null,
      prefixIcon: Icon(Icons.circle),
      prefixIconColor: Colors.green,
      border: OutlineInputBorder(borderSide: BorderSide.none),
    );
    final AlertDialog dialog = AlertDialog(
      title: const Text('Warning'),
      contentPadding: const EdgeInsets.all(8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('You need to be logged in to save your memories!'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signin');
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          height: widget.paperHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'textures/my-papyrus.png',
                fit: BoxFit.fill,
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: widget.thing1,
                      style: b1,
                      decoration: dec,
                    ),
                    TextFormField(
                      controller: widget.thing2,
                      style: b1,
                      decoration: dec,
                    ),
                    TextFormField(
                      controller: widget.thing3,
                      style: b1,
                      decoration: dec,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'On a scale from 0-10, how happy did you truly feel today?',
                        style: b2,
                      ),
                    ),
                    Slider(
                      onChanged: (double newVal) {
                        setState(() {
                          widget.happiness = newVal.toInt();
                        });
                      },
                      value: widget.happiness.toDouble(),
                      label: widget.happiness.toString(),
                      max: 10,
                      min: 0,
                      divisions: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (5 * screenWidth / 18), vertical: 20.0),
          child: ElevatedButton(
            onPressed: () async {
              if (user != null) {
                print('se salveaza');
                String date = DateTime.now().toString().substring(0, 10);
                Robertstore().Add_entry_good_paper(
                    user!.uid.toString(),
                    date,
                    widget.thing1.text,
                    widget.thing2.text,
                    widget.thing3.text,
                    widget.happiness);
                widget.thing1.text =
                    widget.thing2.text = widget.thing3.text = "";

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                print("am incercat");
              } else {
                showDialog<void>(
                    context: context, builder: (context) => dialog);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Save',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
