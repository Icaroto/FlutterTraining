import 'package:flutter/material.dart';
import 'package:proto_dex/pokedex/pokedex_details_screen.dart';
import '../components/image.dart';
import '../models/pokemon.dart';

class PokemonTiles extends StatefulWidget {
  const PokemonTiles(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange});

  final Color? tileColor;
  final List<Pokemon> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;

  @override
  State<PokemonTiles> createState() => _PokemonTiles();
}

class _PokemonTiles extends State<PokemonTiles> {
  @override
  Widget build(BuildContext context) {
    Pokemon pokemon = widget.pokemons[widget.indexes.first];

    for (var i = 1; i < widget.indexes.length; i++) {
      pokemon = pokemon.forms[widget.indexes[i]];
    }

    return Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PokedexDetailsPage(
                  pokemons: widget.pokemons,
                  indexes: widget.indexes,
                );
              },
            ),
          )
        },
        leading: ListImage(image: 'mons/${pokemon.image[0]}'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                (pokemon.formName == "") ? pokemon.name : pokemon.formName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text("#${pokemon.number}")
          ],
        ),
        trailing: const Text(''),
        subtitle: Text(pokemon.formattedTypes()),
      ),
    );
  }
}
