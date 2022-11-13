import 'package:flutter/material.dart';
import '../../components/basic.dart';
import '../../models/enums.dart';
import '../../models/pokemon.dart';

class BreedingInformationCard extends StatelessWidget {
  const BreedingInformationCard({
    Key? key,
    required this.pokemon,
    required this.onImageChange,
  }) : super(key: key);

  final Pokemon pokemon;
  final Function(int p1) onImageChange;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "Breeding",
      cardChild: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: pokemon.breeding.groups
                    .map((i) => Text(
                          "- $i",
                          style: const TextStyle(color: Colors.white),
                        ))
                    .toList(),
              ),
              const TextDivider(text: "Cycles"),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: pokemon.breeding.cycles,
                      children: <TextSpan>[
                        TextSpan(
                          text: "  ${pokemon.breeding.getSteps()}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const TextDivider(text: "Gender Ratio"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: genderButtons(pokemon),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<GenderButton> genderButtons(Pokemon pokemon) {
    if (pokemon.imageGender() == PokemonGender.genderless) {
      return [
        const GenderButton(
          onPressed: null,
          icon: Icon(Icons.close),
          text: 'Genderless',
        )
      ];
    }
    return [
      GenderButton(
          onPressed: (pokemon.imageHasGenderAlter()
              ? () => onImageChange(
                  pokemon.findImageIndexByGender(PokemonGender.male))
              : null),
          icon: const Icon(
            Icons.male,
            color: Colors.blueAccent,
          ),
          text: pokemon.genderRatio.male),
      GenderButton(
          onPressed: (pokemon.imageHasGenderAlter()
              ? () => onImageChange(
                  pokemon.findImageIndexByGender(PokemonGender.female))
              : null),
          icon: const Icon(
            Icons.female,
            color: Colors.redAccent,
          ),
          text: pokemon.genderRatio.female),
    ];
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({
    required this.onPressed,
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
      ),
      onPressed: onPressed,
      icon: icon,
      label: Text(text),
    );
  }
}
