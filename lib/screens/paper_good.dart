import 'package:flutter/material.dart';

class PaperGood extends StatefulWidget {
  const PaperGood({Key? key}) : super(key: key);

  @override
  State<PaperGood> createState() => _PaperGoodState();
}

class _PaperGoodState extends State<PaperGood> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(), //paper bad sau gud
        VerticalDivider(),
        NavigationRail(
          // leading: FloatingActionButton(
          //   onPressed: () {},
          //   child: const Icon(Icons.add),
          // ),
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
    );
  }
}
