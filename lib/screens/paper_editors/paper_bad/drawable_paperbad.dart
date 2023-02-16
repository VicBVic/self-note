import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_editors/burnable_paper.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable.dart';
import 'package:painter/painter.dart';

import '../../../consts.dart';

class DrawablePaperBad extends StatefulWidget {
  DrawablePaperBad({
    Key? key,
    required PainterController controller,
    required this.forMobile,
    required this.paintsWithBrush,
    required this.animationController,
  })  : painterController = controller,
        super(key: key);
  final PainterController painterController;
  final AnimationController animationController;
  final forMobile;
  bool paintsWithBrush;

  @override
  State<DrawablePaperBad> createState() => _DrawablePaperBadState();
}

class _DrawablePaperBadState extends State<DrawablePaperBad> {
  TextEditingController textController =
      TextEditingController(text: '\n\n\n\nstart typing here...');

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BurnablePaper(
          animationController: widget.animationController,
        ),
        widget.paintsWithBrush
            ? TextFieldOnPaper(
                controller: textController,
              )
            : Painter(widget.painterController),
        widget.paintsWithBrush
            ? Painter(widget.painterController)
            : TextFieldOnPaper(
                controller: textController,
              ),
      ],
    );
  }
}

class TextFieldOnPaper extends StatelessWidget {
  final TextEditingController controller;
  const TextFieldOnPaper({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.bottom,
      controller: controller,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      style: const TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.multiline,
      minLines: 25,
      maxLines: 25,
    );
  }
}
