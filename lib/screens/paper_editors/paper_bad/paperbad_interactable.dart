//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itec20222/consts.dart';
import 'package:itec20222/screens/paper_editors/burnable_paper.dart';
import 'package:itec20222/classes/color_picker_button.dart';
import 'package:itec20222/screens/paper_editors/paper_bad/paperbad_interactable_rail.dart';
import 'package:painter/painter.dart';

import 'drawable_paperbad.dart';

class PaperBadInteractable extends StatefulWidget {
  final AnimationController animationController;
  PaperBadInteractable({
    Key? key,
    required this.forMobile,
    required this.animationController,
  }) : super(key: key);

  bool forMobile = false;
  @override
  State<PaperBadInteractable> createState() => _PaperBadInteractableState();
}

class _PaperBadInteractableState extends State<PaperBadInteractable> {
  int paintsWithBrush = 0;

  final PainterController _controller = _newController();

  static PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = const Color.fromARGB(0, 0, 0, 0);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    //if(!widget.forMobile)
    {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Flexible(
              child: DrawablePaperBad(
                paintsWithBrush: (paintsWithBrush == 1),
                controller: _controller,
                forMobile: widget.forMobile,
                animationController: widget.animationController,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: PaperbadInteractableRail(
                  onDestinationSelected: (index) => setState(() {
                        paintsWithBrush = index;
                      }),
                  selectedIndex: paintsWithBrush,
                  controller: _controller),
            )
          ],
        ),
      );
    }
  }
}
