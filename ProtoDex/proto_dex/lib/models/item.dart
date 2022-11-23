import 'package:proto_dex/models/enums.dart';
import 'package:proto_dex/models/pokemon.dart';

import '../constants.dart';

class Item {
  final String name;
  final String number;
  final PokemonType type1;
  final PokemonType? type2;
  final List<Item> forms;
  final List<dynamic> image;
  PokemonGender gender;
  String ability;
  PokeballType ball;
  String level;
  bool captured;

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        number = json['number'],
        image = json['image'],
        gender = PokemonGender.values.byName(json['gender']),
        type1 = PokemonType.values.byName(json['type1']),
        type2 = json['type2'] == null
            ? null
            : PokemonType.values.byName(json['type2']),
        ability = json['ability'],
        ball = PokeballType.values.byName(json['ball']),
        captured = json['captured'],
        level = json['level'],
        forms = json['forms'] != null
            ? List<Item>.from(
                json['forms'].map((model) => Item.fromJson(model)))
            : [];

  Item.fromDex(Pokemon dexPokemon, {String replaceNumber = ""})
      : name = dexPokemon.name,
        number = (replaceNumber == "") ? dexPokemon.number : replaceNumber,
        image = dexPokemon.image,
        type1 = dexPokemon.type1,
        type2 = dexPokemon.type2,
        forms = dexPokemon.forms.isNotEmpty
            ? List<Item>.from(dexPokemon.forms.map(
                (model) => Item.fromDex(model, replaceNumber: replaceNumber)))
            : [],
        gender = PokemonGender.undefinied,
        ball = PokeballType.undefined,
        captured = false,
        level = kValueNotFound,
        ability = kValueNotFound;

  Item.copy(Item item)
      : name = item.name,
        number = item.number,
        image = item.image,
        type1 = item.type1,
        type2 = item.type2,
        forms = [],
        gender = item.gender,
        ball = item.ball,
        captured = item.captured,
        level = item.level,
        ability = item.ability;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'image': image,
      'type1': type1.name,
      'type2': type2?.name,
      'forms': forms.map((i) => i.toJson()).toList(),
      'gender': gender.name,
      'ball': ball.name,
      'captured': captured,
      'ability': ability,
      'level': level,
    };
  }
}
