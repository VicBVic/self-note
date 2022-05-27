import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaperBadInteractable extends StatefulWidget {
  const PaperBadInteractable({Key? key}) : super(key: key);

  @override
  State<PaperBadInteractable> createState() => _PaperBadInteractableState();
}

class _PaperBadInteractableState extends State<PaperBadInteractable> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000.0,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Image.asset(
              "textures/dummy-no-royalty.jpg",
              fit: BoxFit.fill,
            ),
          ),
          VerticalDivider(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: NavigationRail(
              selectedIconTheme:
                  Theme.of(context).navigationRailTheme.selectedIconTheme,
              selectedLabelTextStyle:
                  Theme.of(context).navigationRailTheme.selectedLabelTextStyle,
              selectedIndex: _selectedIndex,
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
        ],
      ),
    );
  }
}
