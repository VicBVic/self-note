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

final user = FirebaseAuth.instance.currentUser;

class PaperGoodInteractable extends StatefulWidget {
  List<TextEditingController> thing = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final double paperHeight;
  late double padding;
  int happiness = 5;
  PaperGoodInteractable({
    Key? key,
    this.paperHeight = 250,
    required this.padding,
  }) : super(key: key);

  void save() async {
    String date = DateTime.now().toString().substring(0, 10);

    if (user != null) {
      Robertstore().Add_entry_good_paper(user!.uid.toString(), date,
          thing[1].text, thing[2].text, thing[3].text, happiness);
      thing[1].text = thing[2].text = thing[3].text = "";
      //print(object)
    }
  }

  @override
  State<PaperGoodInteractable> createState() => _PaperGoodInteractableState();
}

class _PaperGoodInteractableState extends State<PaperGoodInteractable> {
  int _selectedIndex = 0;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var b1 = Theme.of(context).textTheme.headline3!.copyWith(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 24);
    var b2 =
        Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black);

    InputDecoration dec = InputDecoration(
      contentPadding: null,
      prefixIcon: Icon(Icons.circle),
      prefixIconColor: Colors.green,
      border: OutlineInputBorder(borderSide: BorderSide.none),
    );

    return Container(
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
                  controller: widget.thing[1],
                  style: b1,
                  decoration: dec,
                ),
                TextFormField(
                  controller: widget.thing[2],
                  style: b1,
                  decoration: dec,
                ),
                TextFormField(
                  controller: widget.thing[3],
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
    );
  }
}
