import 'package:flutter/material.dart';
import 'package:proto_dex/components/catch_card.dart';
import 'package:proto_dex/lookingfor/lookingfor_details_screen.dart';
import '../components/image.dart';
import '../constants.dart';
import '../models/enums.dart';
import '../models/game.dart';
import '../models/item.dart';

class LookingForTile extends StatefulWidget {
  const LookingForTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange,
      this.onDelete});

  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;
  final Function(Item)? onDelete;

  @override
  State<LookingForTile> createState() => _LookingForTile();
}

class _LookingForTile extends State<LookingForTile> {
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
                return LookingForDetailsPage(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        subtitle: (pokemon.ability != kValueNotFound ||
                pokemon.ball != PokeballType.undefined)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (pokemon.ability != kValueNotFound)
                    Text(
                      pokemon.ability,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  if (pokemon.ball != PokeballType.undefined)
                    SizedBox(
                      height: 25,
                      child: Image.network(
                        pokemon.ball.getImagePath(),
                      ),
                    ),
                ],
              )
            : null,
        trailing: (pokemon.originalLocation.isNotEmpty)
            ? SizedBox(
                height: 50,
                child: Image.network(
                  '$kImageLocalPrefix${Game.gameIcon(pokemon.originalLocation)}',
                ),
              )
            : null,
      ),
    );
  }
}
