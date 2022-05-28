import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itec20222/consts.dart';
import 'package:itec20222/screens/paper_editors/paper.dart';
import 'package:itec20222/classes/color_picker_button.dart';
import 'package:painter/painter.dart';

class PaperBadInteractable extends StatefulWidget {
  final bool burning;
  final double? paperHeight;
  PaperBadInteractable({
    Key? key,
    this.burning = false,
    this.paperHeight = 750,
    required this.forMobile,
  }) : super(key: key);

  bool forMobile = false;
  @override
  State<PaperBadInteractable> createState() => _PaperBadInteractableState();
}

class _PaperBadInteractableState extends State<PaperBadInteractable> {
  int _selectedIndex = 0;

  PainterController _controller = _newController();

  static PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Color.fromARGB(0, 0, 0, 0);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    //if(!widget.forMobile)
    {
      return Container(
        padding: EdgeInsets.all(20),
        height: widget.paperHeight,
        child: Row(
          children: [
            DrawablePaperBad(
              widget: widget,
              controller: _controller,
              forMobile: widget.forMobile,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: NavigationRail(
                      selectedIconTheme: Theme.of(context)
                          .navigationRailTheme
                          .selectedIconTheme,
                      selectedLabelTextStyle: Theme.of(context)
                          .navigationRailTheme
                          .selectedLabelTextStyle,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.selected,
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.text_fields_outlined,
                          ),
                          label: Text(
                            'Write Text',
                          ),
                        ),
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.brush_outlined,
                          ),
                          label: Text(
                            'Draw',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[700],
                  ),
                  IconButton(
                      icon: new Icon(
                        Icons.undo,
                      ),
                      tooltip: 'Undo',
                      onPressed: () {
                        if (_controller.isEmpty) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) =>
                                  Text('Nothing to undo'));
                        } else {
                          _controller.undo();
                        }
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: 'Clear',
                      onPressed: _controller.clear),
                  ColorPickerButton(_controller, false),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

class DrawablePaperBad extends StatelessWidget {
  DrawablePaperBad(
      {Key? key,
      required this.widget,
      required PainterController controller,
      required this.forMobile})
      : _controller = controller,
        super(key: key);

  final PaperBadInteractable widget;
  final PainterController _controller;
  final forMobile;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: forMobile ? 0 : 100.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: paperHeight,
              child: Image.asset(
                'textures/papyrus_paper.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Paper(
                anitmationDuration: Duration(seconds: 10),
                color: Colors.black,
                pointCount: 30,
                burning: widget.burning,
              ),
            ),
            Container(
              height: paperHeight,
              child: Image.asset(
                'textures/paper_border.png',
                fit: BoxFit.fill,
              ),
            ),
            Painter(_controller),
          ],
        ),
      ),
    );
  }
}
