import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/tracker/tracker_tiles.dart';
import '../../components/image.dart';
import '../../models/enums.dart';
import '../../models/item.dart';

Widget createCards(
  List<Item> pokemons,
  List<int> indexes, {
  Function()? onStateChange,
  subLevel = false,
}) {
  final GlobalKey expansionTileKey = GlobalKey();

  Item pokemon = pokemons.current(indexes);

  if (pokemon.forms.isEmpty) {
    return TrackerTile(
      tileColor: (subLevel) ? null : Colors.black26,
      pokemons: pokemons,
      indexes: indexes,
      onStateChange: onStateChange,
    );
  }

  void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 240)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  var image = "mons/${pokemon.displayImage}";
  bool shadow = kPreferences.revealUncaught == false &&
      Item.isCaptured(pokemon) != CaptureType.full;

  return Card(
    child: ExpansionTile(
      key: expansionTileKey,
      initiallyExpanded: false,
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
            pokemon.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("#${pokemon.number}")
        ],
      ),
      trailing: Text('         +${pokemon.forms.length - 1}'),
      subtitle: null,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return createCards(pokemons, [...indexes, index2],
                onStateChange: onStateChange, subLevel: true);
          },
          itemCount: pokemon.forms.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ],
    ),
  );
}
