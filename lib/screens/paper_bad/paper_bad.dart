import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itec20222/screens/paper_bad/paperbad_interactable.dart';

class PaperBad extends StatefulWidget {
  const PaperBad({Key? key}) : super(key: key);

  @override
  State<PaperBad> createState() => _PaperBadState();
}

class _PaperBadState extends State<PaperBad> {
  String desc = "";

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.headline2!;
    TextStyle h2 = Theme.of(context).textTheme.headline2!;
    TextStyle b1 = Theme.of(context).textTheme.bodyLarge!;
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        const PaperBadInteractable(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Wait, what is this?',
            style: h1.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Text(desc, style: b1.copyWith(fontSize: 22.0, height: 1.5)),
        ),
      ],
    );
  }

  @override
  void initState() {
    loadTexts();
  }

  void loadTexts() async {
    print("yep");
    await rootBundle.loadString('strings/paperbad-desc.txt').then((value) {
      setState(() {
        desc = value;
        print('aci');
      });
    });
  }
}
