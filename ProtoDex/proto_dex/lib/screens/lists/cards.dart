import 'package:flutter/material.dart';
import 'package:proto_dex/screens/lists/tile.dart';
import '../../components/image.dart';
import '../../models/item.dart';

Widget singleCard(context, index, pokemons) {
  return PokemonTile(
    tileColor: Colors.black26,
    pokemon: pokemons[index],
  );
}

Widget multipleCards(context, index, pokemons) {
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
  if (pokemons is List<Item>) {
    image = pokemons[index].displayImage;
  } else {
    image = pokemons[index].image[0];
  }

  return Card(
    child: ExpansionTile(
      key: expansionTileKey,
      onExpansionChanged: (value) {
        if (value) {
          scrollToSelectedContent(expansionTileKey: expansionTileKey);
        }
      },
      collapsedBackgroundColor: Colors.black26,
      backgroundColor: Colors.black26,
      leading: ListImage(image: image),
      title: Text(pokemons[index].name),
      //The space is to try to align the number from a Card with forms with a card without forms
      trailing: Text('         +${pokemons[index].forms.length - 1}'),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (pokemons is List<Item>)
              ? Text(pokemons[index].game.notes)
              : Text(pokemons[index].formattedTypes()),
          Text(pokemons[index].number)
        ],
      ),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return PokemonTile(
              pokemon: pokemons[index].forms[index2],
            );
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
