import 'package:flutter/material.dart';
import '../../components/image.dart';
import '../../models/group.dart';
import '../../collection/collection_tile.dart';
import '../models/item.dart';

Widget singleCard(
    context, index, List<Item> pokemons, Function()? onStateChange,
    {color = Colors.black26}) {
  return CollectionTile(
    pokemon: pokemons[index],
    onStateChange: onStateChange,
  );
}

Widget multipleCards(context, Group group, Function()? onStateChange,
    {subLevel = false}) {
  final GlobalKey expansionTileKey = GlobalKey();

  void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 240)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  // var image = pokemons[index].displayImage;
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: ExpansionTile(
      key: expansionTileKey,
      onExpansionChanged: (value) {
        if (value) {
          scrollToSelectedContent(expansionTileKey: expansionTileKey);
        }
      },
      collapsedBackgroundColor:
          (group.color == null) ? Colors.black26 : group.color,
      backgroundColor: (group.color == null) ? Colors.black26 : group.color,

      // collapsedBackgroundColor: (subLevel) ? null : Colors.black26,
      // backgroundColor: (subLevel) ? Colors.black12 : Colors.black26,
      leading: ListImage(
        image: group.image,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            group.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text("#${pokemons[index].number}")
        ],
      ),
      trailing: Text('+${group.items.length}'),
      // subtitle: Text(pokemons[index].formattedTypes()),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return CollectionTile(
              pokemon: group.items[index2],
              onStateChange: onStateChange,
            );
          },
          itemCount: group.items.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ],
    ),
  );
}
