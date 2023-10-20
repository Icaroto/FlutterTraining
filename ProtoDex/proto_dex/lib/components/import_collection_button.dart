import 'package:flutter/material.dart';

import '../models/item.dart';
import '../utils/collection_manager.dart';

class ImportToCollectionButton extends StatelessWidget {
  const ImportToCollectionButton({
    required this.listToImport,
    super.key,
  });

  final List<Item> listToImport;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          addItemsToCollection(listToImport);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.amber;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.blueGrey[800];
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              return Colors.amber[800];
            },
          ),
        ),
        child: const Text("Import to collection"),
      ),
    );
  }
}
