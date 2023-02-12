import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_paperstack.dart';
import 'package:painter/painter.dart';

import '../../../consts.dart';

class DrawablePaperBad extends StatefulWidget {
  DrawablePaperBad({
    Key? key,
    required this.widget,
    required PainterController controller,
    required this.forMobile,
    required this.paintsWithBrush,
    required this.animationController,
  })  : painterController = controller,
        super(key: key);
  final PaperBadInteractable widget;
  final PainterController painterController;
  final AnimationController animationController;
  final forMobile;
  bool paintsWithBrush;

  @override
  State<DrawablePaperBad> createState() => _DrawablePaperBadState();
}

class _DrawablePaperBadState extends State<DrawablePaperBad> {
  String initText = '';

  @override
  Widget build(BuildContext context) {
    Widget theTextFieldOnPaper = Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 100),
      child: TextFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        initialValue: initText,
        onChanged: (value) {
          setState(() {
            initText = value;
          });
        },
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: TextInputType.multiline,
        minLines: 25,
        maxLines: 25,
      ),
    );

    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.forMobile ? 0 : 100.0),
        child: Stack(
          children: [
            PaperbadPaperstack(
              animationController: widget.animationController,
              paperHeight: paperHeight,
            ),
            widget.paintsWithBrush
                ? theTextFieldOnPaper
                : Painter(widget.painterController),
            widget.paintsWithBrush
                ? Painter(widget.painterController)
                : theTextFieldOnPaper,
          ],
        ),
      ),
    );
  }
}
