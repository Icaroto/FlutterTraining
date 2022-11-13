import 'package:flutter/material.dart';
import 'package:proto_dex/screens/details_screen.dart';
import '../../components/image.dart';
import '../../models/item.dart';
import '../../models/pokemon.dart';

class PokemonTile extends StatefulWidget {
  const PokemonTile({super.key, required this.pokemon, this.tileColor});

  final Color? tileColor;
  final Pokemon pokemon;

  @override
  State<PokemonTile> createState() => _PokemonTile();
}

class _PokemonTile extends State<PokemonTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DetailsPage(pokemon: widget.pokemon);
              },
            ),
          )
        },
        leading: ListImage(image: widget.pokemon.image[0]),
        title: Text(widget.pokemon.name),
        trailing: const Text(''),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.pokemon.formattedTypes()),
            Text(widget.pokemon.number)
          ],
        ),
      ),
    );
  }
}

class PokemonCheckTile extends StatefulWidget {
  const PokemonCheckTile({super.key, required this.pokemon, this.tileColor});

  final Color? tileColor;
  final Item pokemon;

  @override
  State<PokemonCheckTile> createState() => _PokemonCheckTile();
}

class _PokemonCheckTile extends State<PokemonCheckTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return DetailsPage(pokemon: widget.pokemon);
          //     },
          //   ),
          // )
        },
        leading: ListImage(image: widget.pokemon.image[0]),
        title: Text(widget.pokemon.name),
        trailing: Checkbox(
          value: widget.pokemon.captured,
          onChanged: (value) {
            setState(
              () {
                widget.pokemon.captured = value!;
              },
            );
          },
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO: formatedTypes
            Text(widget.pokemon.type1.name),
            Text(widget.pokemon.number)
          ],
        ),
      ),
    );
  }
}
