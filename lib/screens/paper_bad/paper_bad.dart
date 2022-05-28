import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itec20222/screens/paper_bad/paperbad_interactable.dart';
import 'package:itec20222/widgets/footer.dart';

class PaperBad extends StatefulWidget {
  const PaperBad({Key? key}) : super(key: key);

  @override
  State<PaperBad> createState() => _PaperBadState();
}

// Enum PaperActionStates = {
//   int a=0;
// };

class _PaperBadState extends State<PaperBad> {
  String desc = "";

  void burnPaper() {}

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.headline2!;
    TextStyle h2 = Theme.of(context).textTheme.headline2!;
    TextStyle b1 = Theme.of(context).textTheme.bodyLarge!;
    return Column(
      //shrinkWrap: true,
      //scrollDirection: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PaperBadInteractable(),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 300.0, vertical: 20.0),
          child: ElevatedButton(
            onPressed: () {
              burnPaper();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Burn',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 64.0),
          child: Text(
            'Wait, what is this?',
            style: h1.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 32),
          child: Text(desc, style: b1.copyWith(fontSize: 22.0, height: 1.5)),
        ),
        Footer(),
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
