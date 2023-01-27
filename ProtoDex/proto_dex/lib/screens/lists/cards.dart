import 'package:flutter/material.dart';
import 'package:proto_dex/models/pokemon.dart';
import 'package:proto_dex/screens/lists/tile.dart';
import '../../components/image.dart';
import '../../models/item.dart';

Widget singleCard(context, index, pokemons, {color = Colors.black26}) {
  return PokemonTile(
    tileColor: color,
    pokemon: pokemons[index],
  );
}

Widget multipleCards(context, index, pokemons, {subLevel = false}) {
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
      collapsedBackgroundColor: (subLevel) ? null : Colors.black26,
      backgroundColor: (subLevel) ? Colors.black12 : Colors.black26,
      leading: ListImage(image: image),
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
      subtitle: (pokemons is List<Pokemon>)
          ? Text(pokemons[index].formattedTypes())
          : null,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return (pokemons[index].forms[index2].forms.isEmpty)
                // ? PokemonTile(
                //     pokemon: pokemons[index].forms[index2],
                //   )
                ? singleCard(context, index2, pokemons[index].forms,
                    color: null)
                : multipleCards(context, index2, pokemons[index].forms,
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
