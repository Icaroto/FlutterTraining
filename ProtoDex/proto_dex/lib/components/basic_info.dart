import 'package:flutter/material.dart';
import '../components/pokemon.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontFamily: 'SigmarOne',
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              Text(
                pokemon.number,
                style: const TextStyle(
                  fontFamily: 'SigmarOne',
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(thickness: 2, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PokeAtt(type: pokemon.type1),
              if (pokemon.type2 != null) PokeAtt(type: pokemon.type2),
            ],
          ),
        ],
      ),
    );
  }
}

class PokeAtt extends StatelessWidget {
  const PokeAtt({super.key, required this.type});

  final PokemonType? type;

  Image getTypeIcon(PokemonType? type) {
    switch (type) {
      case PokemonType.bug:
        return Image.asset('images/types/bug.png');
      case PokemonType.dark:
        return Image.asset('images/types/dark.png');
      case PokemonType.dragon:
        return Image.asset('images/types/dragon.png');
      case PokemonType.electric:
        return Image.asset('images/types/electric.png');
      case PokemonType.fire:
        return Image.asset('images/types/fire.png');
      case PokemonType.grass:
        return Image.asset('images/types/grass.png');
      case PokemonType.fairy:
        return Image.asset('images/types/fairy.png');
      case PokemonType.fighting:
        return Image.asset('images/types/fighting.png');
      case PokemonType.flying:
        return Image.asset('images/types/flying.png');
      case PokemonType.ghost:
        return Image.asset('images/types/ghost.png');
      case PokemonType.ground:
        return Image.asset('images/types/ground.png');
      case PokemonType.ice:
        return Image.asset('images/types/ice.png');
      case PokemonType.normal:
        return Image.asset('images/types/normal.png');
      case PokemonType.poison:
        return Image.asset('images/types/poison.png');
      case PokemonType.psychic:
        return Image.asset('images/types/psychic.png');
      case PokemonType.rock:
        return Image.asset('images/types/rock.png');
      case PokemonType.steel:
        return Image.asset('images/types/steel.png');
      case PokemonType.water:
        return Image.asset('images/types/water.png');
      default:
        throw ("Pokemon Type do not have a primary color defined");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 1, color: Colors.green),
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: 60,
        width: 60,
        child: getTypeIcon(type),
      ),
    );
  }
}
