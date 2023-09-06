import 'package:flutter/material.dart';
import 'package:proto_dex/components/catch_card.dart';
import 'package:proto_dex/fortrade/fortrade_details_screen.dart';
import '../components/image.dart';
import '../constants.dart';
import '../models/enums.dart';
import '../models/game.dart';
import '../models/item.dart';

class ForTradeTile extends StatefulWidget {
  const ForTradeTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange,
      this.onDelete});

  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function(Item)? onStateChange;
  final Function(Item)? onDelete;

  @override
  State<ForTradeTile> createState() => _ForTradeTile();
}

class _ForTradeTile extends State<ForTradeTile> {
  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);

    return Card(
      child: ListTile(
          tileColor: widget.tileColor,
          textColor: Colors.black,
          onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ForTradeDetailsPage(
                        pokemons: widget.pokemons,
                        indexes: widget.indexes,
                        onStateChange: widget.onStateChange,
                      );
                    },
                  ),
                ),
              },
          onLongPress: () {
            widget.onDelete!(pokemon);
          },
          leading: ListImage(image: "mons/${pokemon.displayImage}"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: pokemon.displayName,
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    if (pokemon.gender != PokemonGender.genderless &&
                        pokemon.gender != PokemonGender.undefinied)
                      TextSpan(
                          text: ' (${pokemon.gender.getSingleLetter()})',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (pokemon.level != "" && pokemon.level != kValueNotFound)
                      TextSpan(
                          text: ' (${pokemon.level})',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (pokemon.ability != kValueNotFound) ? pokemon.ability : "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                  height: 25,
                  child: (pokemon.ball != PokeballType.undefined)
                      ? Image.network(
                          pokemon.ball.getImagePath(),
                        )
                      : null),
            ],
          ),
          trailing: SizedBox(
            height: 50,
            width: 50,
            child: (pokemon.originalLocation.isNotEmpty)
                ? Image.network(
                    '$kImageLocalPrefix${Game.gameIcon(pokemon.originalLocation)}',
                  )
                : null,
          )),
    );
  }
}
