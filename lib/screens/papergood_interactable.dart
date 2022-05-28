import 'package:flutter/material.dart';

class PaperGoodInteractable extends StatefulWidget {
  const PaperGoodInteractable({Key? key}) : super(key: key);

  @override
  State<PaperGoodInteractable> createState() => _PaperGoodInteractableState();
}

class _PaperGoodInteractableState extends State<PaperGoodInteractable> {
  int _selectedIndex = 0;
  double paperHeight = 600;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: paperHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Image.asset(
              'parchment.png',
              fit: BoxFit.fill,
            ),
          ), //hartia in sine
          VerticalDivider(),
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(
                  Icons.text_fields_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.text_fields_rounded,
                ),
                label: Text(
                  'Write Text',
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(
                  Icons.brush_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.brush,
                ),
                label: Text(
                  'Draw',
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.favorite_border),
                selectedIcon: const Icon(
                  Icons.favorite,
                ),
                label: Text(
                  'Add hearts',
                ),
              ),
              NavigationRailDestination(
                icon: const Icon(
                  Icons.star_border,
                ),
                selectedIcon: const Icon(
                  Icons.star,
                ),
                label: Text(
                  'Add stars',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
