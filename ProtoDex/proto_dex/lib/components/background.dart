import 'package:flutter/material.dart';
import '../components/constants.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.type1, this.type2});

  final PokemonType type1;
  final PokemonType? type2;

  Color selectColorByType(PokemonType type, bool isSecondaryColor) {
    switch (type) {
      case PokemonType.bug:
        return (!isSecondaryColor) ? Colors.lightGreen : Colors.black;
      case PokemonType.dark:
        return (!isSecondaryColor) ? Colors.black : Colors.black26;
      case PokemonType.dragon:
        return (!isSecondaryColor) ? Colors.indigo : Colors.black;
      case PokemonType.electric:
        return (!isSecondaryColor) ? Colors.yellow : Colors.black;
      case PokemonType.fire:
        return (!isSecondaryColor)
            ? Colors.red
            : const Color.fromARGB(255, 174, 79, 79);
      case PokemonType.grass:
        return (!isSecondaryColor) ? Colors.green : Colors.black;
      case PokemonType.fairy:
        return (!isSecondaryColor) ? Colors.pink : Colors.black;
      case PokemonType.fighting:
        return (!isSecondaryColor) ? Colors.orange : Colors.black;
      case PokemonType.flying:
        return (!isSecondaryColor) ? Colors.blue : Colors.black;
      case PokemonType.ghost:
        return (!isSecondaryColor) ? Colors.purple : Colors.black;
      case PokemonType.ground:
        return (!isSecondaryColor) ? Colors.orange : Colors.black;
      case PokemonType.ice:
        return (!isSecondaryColor) ? Colors.blue : Colors.black;
      case PokemonType.normal:
        return (!isSecondaryColor) ? Colors.grey : Colors.black;
      case PokemonType.poison:
        return (!isSecondaryColor) ? Colors.purple : Colors.black;
      case PokemonType.psychic:
        return (!isSecondaryColor) ? Colors.pink : Colors.black;
      case PokemonType.rock:
        return (!isSecondaryColor) ? Colors.orange : Colors.black;
      case PokemonType.steel:
        return (!isSecondaryColor) ? Colors.grey : Colors.black;
      case PokemonType.water:
        return (!isSecondaryColor) ? Colors.blue : Colors.black;
      default:
        throw ("Pokemon Type do not have a primary color defined");
    }
  }

  List<Color> fillColors(PokemonType type1, PokemonType? type2) {
    List<Color> colors = <Color>[];

    colors.add(selectColorByType(type1, false));

    (type2 == null)
        ? colors.add(selectColorByType(type1, true))
        : colors.add(selectColorByType(type2, false));

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
                  image: const AssetImage('images/background/ball_piece_4.png'),
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
                    image: const AssetImage('images/background/ball_light.png'),
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
