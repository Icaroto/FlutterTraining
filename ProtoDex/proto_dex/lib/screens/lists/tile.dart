import 'package:flutter/material.dart';
import 'package:proto_dex/screens/details_screen.dart';
import '../../components/image.dart';
import '../../models/game.dart';
import '../../models/pokemon.dart';

class PokemonTile extends StatefulWidget {
  const PokemonTile(
      {super.key, this.pokemon, this.tileColor, this.onStateChange});

  final Color? tileColor;
  final dynamic pokemon;
  final Function()? onStateChange;

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
            if (widget.onStateChange != null)
              {
                setState(
                  () {
                    widget.onStateChange!();
                  },
                ),
              }
            else
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DetailsPage(pokemon: widget.pokemon);
                    },
                  ),
                )
              }
          },
          leading: ListImage(image: 'mons/${widget.pokemon.image[0]}'),
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
          message: "Trade Only",
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
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailsPage(pokemon: widget.pokemon);
                },
              ),
            ),
          }
        else
          {
            setState(
              () {
                widget.pokemon.captured = true;
                widget.pokemon.catchDate = DateTime.now().toString();
                widget.onStateChange!();
              },
            )
          }
      },
      onLongPress: () {
        setState(
          () {
            widget.pokemon.captured = false;
            widget.pokemon.catchDate = "";
            widget.onStateChange!();
          },
        );
      },
      leading: ListImage(
          image: 'mons/${widget.pokemon.displayImage}',
          shadowOnly: !widget.pokemon.captured),
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
              widget.pokemon.catchDate =
                  (value) ? DateTime.now().toString() : "";
              widget.onStateChange!();
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
        return Game.gameColor("Pokemon Violet");
      case "Scarlet Exclusive":
        return Game.gameColor("Pokemon Scarlet");
      case "Pikachu Exclusive":
        return Game.gameColor("Let's Go Pikachu");
      case "Eevee Exclusive":
        return Game.gameColor("Let's Go Eevee");
      default:
        return Colors.black;
    }
  }
}
