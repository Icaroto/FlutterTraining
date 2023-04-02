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
        child: const Text("Import to collection"),
        onPressed: () {
          addItemsToCollection(listToImport);
        },
      ),
    );
  }
}
