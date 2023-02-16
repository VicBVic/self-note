import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable.dart';

class PaperbadUtility extends StatelessWidget {
  final AnimationController animationController;
  final ScrollController scrollController;
  const PaperbadUtility(
      {super.key,
      required this.animationController,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    TextStyle h1 = Theme.of(context).textTheme.displayMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        );
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      Center(
        child: FittedBox(
          child: Text(
            'Write your negative thoughts on the paper below:',
            style: h1,
          ),
        ),
      ),
      Flexible(
        child: PaperBadInteractable(
          animationController: animationController,
          forMobile: (screenHeight > screenWidth),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          animationController.forward();
          //desc.clear();
          scrollController.animateTo(0.0,
              duration: Duration(seconds: 1), curve: Curves.easeOut);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Burn',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black),
          ),
        ),
      ),
    ]);
  }
}
