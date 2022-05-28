import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:painter/painter.dart';

class PaperBadInteractable extends StatefulWidget {
  const PaperBadInteractable({Key? key}) : super(key: key);

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
    return Container(
      padding: EdgeInsets.all(40),
      height: 800.0,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Stack(
              children: [
                Image.asset(
                  'textures/dummy-no-royalty.jpg',
                  fit: BoxFit.cover,
                ),
                Painter(_controller),
              ],
            ),
          ),
          VerticalDivider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: NavigationRail(
                    selectedIconTheme:
                        Theme.of(context).navigationRailTheme.selectedIconTheme,
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
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite_border),
                        label: Text(
                          'Add hearts',
                        ),
                      ),
                      NavigationRailDestination(
                        icon: Icon(
                          Icons.star_border,
                        ),
                        label: Text(
                          'Add stars',
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
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
                                new Text('Nothing to undo'));
                      } else {
                        _controller.undo();
                      }
                    }),
                IconButton(
                    icon: new Icon(Icons.delete),
                    tooltip: 'Clear',
                    onPressed: _controller.clear),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
