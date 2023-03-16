import 'package:proto_dex/models/enums.dart';
import 'package:proto_dex/models/pokemon.dart';

import '../constants.dart';
import 'game.dart';

class Item {
  final String name;
  final String formName;
  final String number;
  final String natDexNumber;
  final String ref;
  final PokemonType type1;
  final PokemonType? type2;
  final List<Item> forms;
  final List<dynamic> image;
  final Game game;

  String displayName;
  String displayImage;
  PokemonGender gender;
  String ability;
  PokeballType ball;
  String level;
  bool captured;
  String catchDate;
  String origin;

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        formName = json['formName'],
        number = json['number'],
        natDexNumber = json['natDexNumber'],
        ref = json['ref'],
        displayName = json['displayName'],
        displayImage = json['displayImage'],
        image = json['image'],
        gender = PokemonGender.values.byName(json['gender']),
        type1 = PokemonType.values.byName(json['type1']),
        type2 = json['type2'] == null
            ? null
            : PokemonType.values.byName(json['type2']),
        ability = json['ability'],
        ball = PokeballType.values.byName(json['ball']),
        captured = json['captured'],
        catchDate = json['catchDate'],
        origin = json['origin'],
        level = json['level'],
        forms = json['forms'] != null
            ? List<Item>.from(
                json['forms'].map((model) => Item.fromJson(model)))
            : [],
        game = Game.fromJson(json['game']);

  Item.fromDex(Pokemon dexPokemon, Game gameSelected, String entryOrigin,
      {bool useGameDexNumber = false})
      : name = dexPokemon.name,
        formName = dexPokemon.formName,
        number = (useGameDexNumber) ? gameSelected.number : dexPokemon.number,
        natDexNumber = dexPokemon.number,
        ref = dexPokemon.ref,
        displayName = dexPokemon.name,
        displayImage = dexPokemon.image[0],
        image = dexPokemon.image.toList(),
        type1 = dexPokemon.type1,
        type2 = dexPokemon.type2,
        forms = dexPokemon.forms.isNotEmpty
            ? List<Item>.from(dexPokemon.forms.map((model) => Item.fromDex(
                model, gameSelected, entryOrigin,
                useGameDexNumber: useGameDexNumber)))
            : [],
        gender = PokemonGender.undefinied,
        ball = PokeballType.undefined,
        captured = false,
        catchDate = "",
        origin = entryOrigin,
        level = kValueNotFound,
        ability = kValueNotFound,
        game = gameSelected;

  Item.copy(Item item)
      : name = item.name,
        formName = item.formName,
        number = item.number,
        natDexNumber = item.natDexNumber,
        ref = item.ref,
        image = item.image.toList(),
        displayName = item.displayName,
        displayImage = item.displayImage,
        type1 = item.type1,
        type2 = item.type2,
        forms = [],
        gender = item.gender,
        ball = item.ball,
        captured = item.captured,
        catchDate = item.catchDate,
        origin = item.origin,
        level = item.level,
        ability = item.ability,
        game = item.game;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'formName': formName,
      'number': number,
      'natDexNumber': natDexNumber,
      'ref': ref,
      'displayName': displayName,
      'displayImage': displayImage,
      'image': image,
      'type1': type1.name,
      'type2': type2?.name,
      'forms': forms.map((i) => i.toJson()).toList(),
      'gender': gender.name,
      'ball': ball.name,
      'captured': captured,
      'catchDate': catchDate,
      'origin': origin,
      'ability': ability,
      'level': level,
      'game': game,
    };
  }

  formattedTypes() {
    var union = type1.name;
    if (type2 != null) {
      String? uni = type2?.name;
      union = '$union/$uni';
    }
    return union;
  }

  bool hasGenderDiff() {
    if (name == "Oinkologne" || name == "Indeedee" || name == "Meowstic") {
      return false;
    }
    return image.any((img) => !img.contains("-mf.") && !img.contains("-g."));
  }

  static isCaptured(Item pokemon) {
    if (pokemon.forms.isNotEmpty) {
      if (pokemon.forms.every((element) => element.captured == true)) {
        return CaptureType.full;
      }

      if (pokemon.forms.every((element) => element.captured == false)) {
        return CaptureType.empty;
      }

      return CaptureType.partial;
    } else {
      return (pokemon.captured) ? CaptureType.full : CaptureType.empty;
    }
  }
}
