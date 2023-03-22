import 'package:flutter/material.dart';
import 'package:proto_dex/pokedex/pokedex_tiles.dart';
import '../components/image.dart';
import '../models/pokemon.dart';

Widget singleCard(List<Pokemon> pokemons, List<int> indexes,
    {Function()? onStateChange, color = Colors.black26}) {
  return PokemonTiles(
    tileColor: color,
    pokemons: pokemons,
    indexes: indexes,
    onStateChange: onStateChange,
  );
}

Widget multipleCards(List<Pokemon> pokemons, List<int> indexes,
    {Function()? onStateChange, subLevel = false}) {
  final GlobalKey expansionTileKey = GlobalKey();

  Pokemon pokemon = pokemons[indexes.first];

  for (var i = 1; i < indexes.length; i++) {
    pokemon = pokemon.forms[indexes[i]];
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

  var image = "mons/${pokemon.image[0]}";
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
      trailing: Text('+${pokemon.forms.length - 1}'),
      subtitle: Text(pokemon.formattedTypes()),
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return (pokemon.forms[index2].forms.isEmpty)
                ? singleCard(pokemons, [...indexes, index2],
                    onStateChange: onStateChange, color: null)
                : multipleCards(pokemons, [...indexes, index2],
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
