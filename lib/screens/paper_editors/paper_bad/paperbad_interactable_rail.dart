import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

import '../../../classes/color_picker_button.dart';

class PaperbadInteractableRail extends StatelessWidget {
  final void Function(int) onDestinationSelected;
  final int selectedIndex;
  final PainterController controller;
  const PaperbadInteractableRail({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: NavigationRail(
              selectedIconTheme:
                  Theme.of(context).navigationRailTheme.selectedIconTheme,
              selectedLabelTextStyle:
                  Theme.of(context).navigationRailTheme.selectedLabelTextStyle,
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
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
                if (controller.isEmpty) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const Text('Nothing to undo'));
                } else {
                  controller.undo();
                }
              }),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Clear',
              onPressed: controller.clear),
          ColorPickerButton(controller, false),
        ],
      ),
    );
  }
}
