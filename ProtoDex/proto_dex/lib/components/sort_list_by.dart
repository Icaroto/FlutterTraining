import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/enums.dart';

class SortListBy extends StatelessWidget {
  const SortListBy({
    required this.onFilterSelected,
    Key? key,
  }) : super(key: key);

  final Function(FilterType) onFilterSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("Sort By")),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextButton(
              child: const FaIcon(FontAwesomeIcons.arrowDown19),
              onPressed: () {
                onFilterSelected(FilterType.numAsc);
              },
            ),
            TextButton(
              child: const FaIcon(FontAwesomeIcons.arrowDown91),
              onPressed: () {
                onFilterSelected(FilterType.numDesc);
              },
            ),
            TextButton(
              child: const FaIcon(FontAwesomeIcons.arrowDownAZ),
              onPressed: () {
                onFilterSelected(FilterType.nameAsc);
              },
            ),
            TextButton(
              child: const FaIcon(FontAwesomeIcons.arrowDownZA),
              onPressed: () {
                onFilterSelected(FilterType.nameDesc);
              },
            ),
          ],
        ),
      ],
    );
  }
}
