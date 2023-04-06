import 'package:flutter/material.dart';
import 'package:proto_dex/pokedex/pokedex_tiles.dart';
import '../components/image.dart';
import '../models/pokemon.dart';

Widget createCards(
  List<Pokemon> pokemons,
  List<int> indexes, {
  Function()? onStateChange,
  subLevel = false,
}) {
  final GlobalKey expansionTileKey = GlobalKey();

  Pokemon pokemon = pokemons.current(indexes);

  if (pokemon.forms.isEmpty) {
    return PokemonTiles(
      tileColor: (subLevel) ? null : Colors.black26,
      pokemons: pokemons,
      indexes: indexes,
      onStateChange: onStateChange,
    );
  }

  void scrollToPokemon({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 240)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  return Card(
    child: ExpansionTile(
      key: expansionTileKey,
      onExpansionChanged: (value) {
        if (value) {
          scrollToPokemon(expansionTileKey: expansionTileKey);
        }
      },
      collapsedBackgroundColor: (subLevel) ? null : Colors.black26,
      backgroundColor: (subLevel) ? Colors.black12 : Colors.black26,
      leading: ListImage(
        image: "mons/${pokemon.image[0]}",
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
      subtitle: Text(pokemon.formattedTypes()),
      trailing: Text('+${pokemon.forms.length - 1}'),
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
