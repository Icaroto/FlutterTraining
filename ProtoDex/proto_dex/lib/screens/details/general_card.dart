import 'package:flutter/material.dart';
import '../../components/basic.dart';
import '../../models/enums.dart';
import '../../models/pokemon.dart';

class GeneralInformationCard extends StatelessWidget {
  const GeneralInformationCard({
    Key? key,
    required this.pokemon,
    required this.onImageChange,
  }) : super(key: key);

  final Pokemon pokemon;
  final Function(int p1) onImageChange;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "General",
      cardChild: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "- ${pokemon.species}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "- ${pokemon.height}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "- ${pokemon.weight}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const TextDivider(text: "Abilities"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pokemon.abilities
                        .map(
                          (i) => Text(
                            "- $i",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                        .toList(),
                  ),
                  if (pokemon.hiddenAbility != null)
                    Row(
                      children: [
                        if (pokemon.hiddenAbility != "")
                          RichText(
                            text: TextSpan(
                              text: "- ${pokemon.hiddenAbility}",
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' (hidden ability)',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
              const TextDivider(text: "Variant"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    onPressed: () => {
                      (pokemon.imageVariant() == PokemonVariant.normal)
                          ? onImageChange(pokemon
                              .findImageIndexByVariant(PokemonVariant.shiny))
                          : onImageChange(pokemon
                              .findImageIndexByVariant(PokemonVariant.normal)),
                    },
                    child: (pokemon.imageVariant() == PokemonVariant.normal)
                        ? const Icon(Icons.star_border)
                        : const Icon(Icons.circle_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
