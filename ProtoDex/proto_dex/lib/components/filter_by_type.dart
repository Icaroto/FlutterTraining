import 'package:flutter/material.dart';
import '../models/enums.dart';
import 'image.dart';

class FilterByType extends StatelessWidget {
  const FilterByType({
    Key? key,
    required this.selectedTypes,
    required this.onTypeSelected,
    required this.onClearPressed,
  }) : super(key: key);

  final List<String> selectedTypes;
  final Function(List<String> list) onTypeSelected;
  final Function() onClearPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("By Type")),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: PokemonType.values
              .map((item) => ActionChip(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.all(1),
                    backgroundColor: Colors.white60,
                    shadowColor: Colors.blue,
                    elevation: (selectedTypes.contains(item.name)) ? 5 : 0,
                    onPressed: () {
                      (selectedTypes.contains(item.name))
                          ? selectedTypes.remove(item.name)
                          : selectedTypes.add(item.name);

                      onTypeSelected(selectedTypes);
                    },
                    label: TypeIcon(
                        type: PokemonType.values.byName(item.name),
                        size: 23,
                        shadow: false),
                  ))
              .toList()
              .cast<Widget>(),
        ),
        Center(
          child: TextButton(
            onPressed: onClearPressed,
            child: const Text("Clear"),
          ),
        )
      ],
    );
  }
}
