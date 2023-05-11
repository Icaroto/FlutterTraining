import 'package:flutter/material.dart';
import 'package:proto_dex/tracker/tracker_details_screen.dart';
import '../../components/image.dart';
import '../../models/game.dart';
import '../models/item.dart';

class TrackerTile extends StatefulWidget {
  const TrackerTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange});

  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;

  @override
  State<TrackerTile> createState() => _TrackerTile();
}

class _TrackerTile extends State<TrackerTile> {
  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);

    Card card = Card(
      child: ListTile(
        tileColor: widget.tileColor,
        textColor: Colors.black,
        onTap: () => {
          if (pokemon.captured)
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TrackerDetailsPage(
                      pokemons: widget.pokemons,
                      indexes: widget.indexes,
                      onStateChange: widget.onStateChange,
                    );
                  },
                ),
              ),
            }
          else
            {
              setState(
                () {
                  pokemon.captured = true;
                  pokemon.catchDate = DateTime.now().toString();
                  widget.onStateChange!();
                },
              )
            }
        },
        onLongPress: () {
          setState(
            () {
              pokemon.captured = false;
              pokemon.catchDate = "";
              widget.onStateChange!();
            },
          );
        },
        leading: ListImage(
            image: "mons/${pokemon.displayImage}",
            shadowOnly: !pokemon.captured),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pokemon.displayName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("#${pokemon.number}")
          ],
        ),
        trailing: Checkbox(
          value: pokemon.captured,
          onChanged: (value) {
            setState(
              () {
                pokemon.captured = value!;
                pokemon.catchDate = (value) ? DateTime.now().toString() : "";
                widget.onStateChange!();
              },
            );
          },
        ),
      ),
    );

    if (pokemon.game.notes != "") {
      return ClipRect(
        child: Banner(
          message: "Trade Only",
          location: BannerLocation.topEnd,
          color: getBannerColor(pokemon.game.notes),
          child: card,
        ),
      );
    }

    return card;
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
