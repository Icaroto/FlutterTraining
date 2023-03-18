import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import '../../models/enums.dart';
import '../../models/pokemon.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.type1, this.type2});

  final PokemonType type1;
  final PokemonType? type2;

  List<Color> fillColors(PokemonType type1, PokemonType? type2) {
    List<Color> colors = <Color>[];

    colors.add(Pokemon.typeColor(type1, false));

    (type2 == null)
        ? colors.add(Pokemon.typeColor(type1, true))
        : colors.add(Pokemon.typeColor(type2, false));

    return colors.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: fillColors(type1, type2),
              ),
            ),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  scale: 2.5,
                  alignment: Alignment.topLeft,
                  image: const NetworkImage(
                      '${kImageLocalPrefix}background/ball_piece_4.png'),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2),
                    BlendMode.modulate,
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: const NetworkImage(
                        '${kImageLocalPrefix}background/ball_light.png'),
                    scale: 0.5,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.2),
                      BlendMode.modulate,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
