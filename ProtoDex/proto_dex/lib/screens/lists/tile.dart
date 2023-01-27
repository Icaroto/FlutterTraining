import 'package:flutter/material.dart';
import 'package:proto_dex/screens/details_screen.dart';
import '../../components/image.dart';
import '../../models/pokemon.dart';

class PokemonTile extends StatefulWidget {
  const PokemonTile({super.key, this.pokemon, this.tileColor});

  final Color? tileColor;
  final dynamic pokemon;

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (widget.pokemon.formName == "")
                    ? widget.pokemon.name
                    : widget.pokemon.formName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("#${widget.pokemon.number}")
            ],
          ),
          trailing: const Text(''),
          subtitle: Text(widget.pokemon.formattedTypes()),
        ),
      );
    }

    if (widget.pokemon.game.notes == "") {
      return Card(child: createCard(context));
    }
    return Card(
      child: ClipRect(
        child: Banner(
          message: widget.pokemon.game.notes,
          location: BannerLocation.topEnd,
          color: getBannerColor(widget.pokemon.game.notes),
          child: createCard(context),
        ),
      ),
    );
  }

  ListTile createCard(BuildContext context) {
    return ListTile(
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.pokemon.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("#${widget.pokemon.number}")
        ],
      ),
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
      // subtitle: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     // Text(
      //     //   widget.pokemon.game.notes,
      //     //   style: const TextStyle(
      //     //       fontWeight: FontWeight.w200, fontStyle: FontStyle.italic),
      //     // ),
      //     Text(widget.pokemon.number)
      //   ],
      // ),
    );
  }

  getBannerColor(gameNotes) {
    switch (gameNotes) {
      case "Violet Exclusive":
        return Colors.purple;
      case "Scarlet Exclusive":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
