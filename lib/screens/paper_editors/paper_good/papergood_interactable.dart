import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itec20222/consts.dart';
import 'package:itec20222/screens/paper_editors/paper.dart';
import 'package:itec20222/classes/color_picker_button.dart';
import 'package:painter/painter.dart';

final user = FirebaseAuth.instance.currentUser;

class PaperGoodInteractable extends StatefulWidget {
  TextEditingController thing1 = TextEditingController();
  TextEditingController thing2 = TextEditingController();
  TextEditingController thing3 = TextEditingController();

  final double paperHeight;
  final double padding;
  int happiness = 5;
  PaperGoodInteractable({
    Key? key,
    this.paperHeight = 250,
    this.padding = 300,
  }) : super(key: key);

  void save()
  {
    String date = new DateTime.now().toString().substring(0,10);

    if(user!=null)
    {
      FirebaseFirestore.instance.collection(user!.uid.toString()).doc(date).set
      (
        {
          'thing1':thing1.text,
          'thing2':thing2.text,
          'thing3':thing3.text,
          'happiness':happiness
        }
      );
      thing1.text=thing2.text=thing3.text="";
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
    var b1 = Theme.of(context)
        .textTheme
        .headline3!
        .copyWith(color: Colors.black, fontWeight: FontWeight.w800);
    var b2 =
        Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black);

    InputDecoration dec = InputDecoration(
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
          Container(
            child: Paper(
              anitmationDuration: Duration(seconds: 10),
              color: Colors.black,
              pointCount: 30,
              burning: false,
              paperHeight: widget.paperHeight,
            ),
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
                Text(
                  'On a scale from 0-10, how happy did you truly feel today?',
                  style: b2,
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
