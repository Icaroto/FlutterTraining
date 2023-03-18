import 'package:flutter/material.dart';
import 'package:proto_dex/tracker/tracker_tiles.dart';
import '../../components/image.dart';
import '../../models/enums.dart';
import '../../models/item.dart';

Widget singleCard(context, index, pokemons, Function()? onStateChange,
    {color = Colors.black26}) {
  return TrackerTile(
    tileColor: color,
    pokemon: pokemons[index],
    onStateChange: onStateChange,
  );
}

Widget multipleCards(context, index, pokemons, Function()? onStateChange,
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

  var image = "";
  bool shadow = false;
  if (pokemons is List<Item>) {
    image = "mons/${pokemons[index].displayImage}";
    shadow = Item.isCaptured(pokemons[index]) != CaptureType.full;
  } else {
    image = "mons/${pokemons[index].image[0]}";
  }
  return Card(
    child: ExpansionTile(
      key: expansionTileKey,
      onExpansionChanged: (value) {
        if (value) {
          scrollToSelectedContent(expansionTileKey: expansionTileKey);
        }
      },
      collapsedBackgroundColor: (subLevel) ? null : Colors.black26,
      backgroundColor: (subLevel) ? Colors.black12 : Colors.black26,
      leading: ListImage(
        image: image,
        shadowOnly: shadow,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pokemons[index].name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("#${pokemons[index].number}")
        ],
      ),
      trailing: Text('         +${pokemons[index].forms.length - 1}'),
      subtitle: null,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return (pokemons[index].forms[index2].forms.isEmpty)
                ? singleCard(
                    context, index2, pokemons[index].forms, onStateChange,
                    color: null)
                : multipleCards(
                    context, index2, pokemons[index].forms, onStateChange,
                    subLevel: true);
          },
          itemCount: pokemons[index].forms.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ],
    ),
  );
}
