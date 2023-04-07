import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/enums.dart';

class GroupListBy extends StatelessWidget {
  const GroupListBy({
    required this.currentDisplay,
    required this.onDisplaySelected,
    Key? key,
  }) : super(key: key);

  final CollectionDisplayType currentDisplay;
  final Function(CollectionDisplayType) onDisplaySelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("Group By")),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextButton(
              child: const Text("Pokemon"),
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.groupByPokemon);
              },
            ),
            TextButton(
              child: const Text("Game"),
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.groupByGame);
              },
            ),
            TextButton(
              child: const Text("Show All"),
              onPressed: () {
                onDisplaySelected(CollectionDisplayType.flatList);
              },
            ),
          ],
        ),
      ],
    );
  }
}