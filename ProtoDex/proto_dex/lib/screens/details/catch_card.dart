import 'package:flutter/material.dart';
import '../../components/basic.dart';
import '../../models/item.dart';

class CatchInformationCard extends StatelessWidget {
  const CatchInformationCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Item pokemon;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "Catch Info",
      cardChild: Expanded(
          child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 70, height: 70),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
              ),
              onPressed: null,
              // () => {
              // (pokemon.imageVariant() == PokemonVariant.normal)
              //     ? onImageChange(pokemon
              //         .findImageIndexByVariant(PokemonVariant.shiny))
              //     : onImageChange(pokemon
              //         .findImageIndexByVariant(PokemonVariant.normal)),
              // },
              child: Image.asset("images/balls/greatball.png"),
            ),
          ),
          const Divider(),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 70, height: 70),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
              ),
              onPressed: null,
              // () => {
              // (pokemon.imageVariant() == PokemonVariant.normal)
              //     ? onImageChange(pokemon
              //         .findImageIndexByVariant(PokemonVariant.shiny))
              //     : onImageChange(pokemon
              //         .findImageIndexByVariant(PokemonVariant.normal)),
              // },

              child: Text("Pickup Really long text"),
            ),
          ),
        ],
      )),
    );
  }
}
