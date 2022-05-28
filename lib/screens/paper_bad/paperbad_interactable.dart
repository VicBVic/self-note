import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:itec20222/consts.dart';

class PaperBadInteractable extends StatefulWidget {
  const PaperBadInteractable({Key? key}) : super(key: key);

  @override
  State<PaperBadInteractable> createState() => _PaperBadInteractableState();
}

class _PaperBadInteractableState extends State<PaperBadInteractable> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: paperHeight,
      padding: EdgeInsets.all(16.0),
      child: Stack(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            //fit: FlexFit.tight,
            //flex: 1,
            child: Image.asset(
              "textures/my-papyrus.png",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: 100.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: NavigationRail(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                selectedIndex: _selectedIndex,
                extended: false,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.selected,
                destinations: const [
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
          ),
        ],
      ),
    );
  }
}
