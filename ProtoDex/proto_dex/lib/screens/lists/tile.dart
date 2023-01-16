import 'package:flutter/material.dart';
import 'package:proto_dex/screens/details_screen.dart';
import '../../components/image.dart';
import '../../models/item.dart';
import '../../models/pokemon.dart';

class PokemonTile extends StatefulWidget {
  const PokemonTile({super.key, this.pokemon, this.tileColor});

  final Color? tileColor;
  final dynamic pokemon;
  // final Pokemon? pokemon;
  // final Item? item;

  @override
  State<PokemonTile> createState() => _PokemonTile();
}

class _PokemonTile extends State<PokemonTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.pokemon is Pokemon) {
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

    return Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
          if (widget.pokemon.captured)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailsPage(pokemon: widget.pokemon);
                },
              ),
            )
        },
        leading: ListImage(image: widget.pokemon.displayImage),
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

            Text(widget.pokemon.formattedTypes()),
            Text(widget.pokemon.number)
          ],
        ),
      ),
    );
  }
}
