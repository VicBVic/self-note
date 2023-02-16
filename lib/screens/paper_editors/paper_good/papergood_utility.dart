import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_editors/paper_good/papergood_interactable.dart';

class PaperGoodUtility extends StatelessWidget {
  const PaperGoodUtility({super.key});

  @override
  Widget build(BuildContext context) {
    Widget PG = PaperGoodInteractable(
      paperHeight: 400,
      padding: 100,
    );
    TextStyle h1 = Theme.of(context).textTheme.headline2!;
    TextStyle b1 = Theme.of(context).textTheme.bodyLarge!;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(64, 16, 0, 32),
        child: Text(
          'Not all is lightless still.',
          style: h1.copyWith(
              //decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 32),
        child: Text(
            'Try and write down three things that made you happy troughout the day. Search in your memory thouroughly.',
            style: b1.copyWith(fontSize: 22.0, height: 1, color: Colors.black)),
      ),
      Flexible(child: PG),
    ]);
  }
}
