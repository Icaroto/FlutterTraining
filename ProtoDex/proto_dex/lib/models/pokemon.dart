import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'breeding.dart';
import 'gender_ratio.dart';
import 'weakness.dart';
import 'game.dart';
import 'enums.dart';

class Pokemon {
  // Pokemon(
  //     {required this.type1,
  //     required this.type2,
  //     required this.image,
  //     required this.species,
  //     required this.height,
  //     required this.weight,
  //     required this.name,
  //     required this.number,
  //     required this.forms,
  //     required this.games,
  //     required this.weakness,
  //     required this.abilities,
  //     required this.hiddenAbility,
  //     required this.breeding,
  //     required this.genderRatio});

  final String name;
  final String species;
  final String height;
  final String weight;
  final List<dynamic> image;
  final String number;
  final String ref;
  final PokemonType type1;
  final PokemonType? type2;
  final List<Pokemon> forms;
  final List<Game> games;
  final Weakness weakness;
  final List<dynamic> abilities;
  final String? hiddenAbility;
  final Breeding breeding;
  final GenderRatio genderRatio;

  int currentImageIndex = 0;

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        species = json['species'],
        height = json['height'],
        weight = json['weight'],
        image = json['image'],
        number = json['number'],
        ref = json['ref'],
        type1 = PokemonType.values.byName(json['type1']),
        type2 = json['type2'] == null
            ? null
            : PokemonType.values.byName(json['type2']),
        forms = json['forms'] != null
            ? List<Pokemon>.from(
                json['forms'].map((model) => Pokemon.fromJson(model)))
            : [],
        games = json['games'] != null
            ? List<Game>.from(
                json['games'].map((model) => Game.fromJson(model)))
            : [],
        weakness = Weakness(
          quarter: json['weaknessquarter'] ?? [],
          half: json['weaknesshalf'] ?? [],
          none: json['weaknessnone'] ?? [],
          double: json['weaknessdouble'] ?? [],
          quadruple: json['weaknessquadruple'] ?? [],
        ),
        abilities = json['abilities'],
        hiddenAbility = json['hiddenAbility'],
        breeding = Breeding.fromJson(json['breeding']),
        genderRatio = GenderRatio.fromJson(json['genderRatio']);

  Pokemon.copy(Pokemon pokemon, bool keepForms)
      : name = pokemon.name,
        species = pokemon.species,
        height = pokemon.height,
        weight = pokemon.weight,
        image = pokemon.image,
        number = pokemon.number,
        ref = pokemon.ref,
        type1 = pokemon.type1,
        type2 = pokemon.type2,
        forms = (keepForms) ? pokemon.forms : [],
        games = pokemon.games,
        weakness = pokemon.weakness,
        abilities = pokemon.abilities,
        hiddenAbility = pokemon.hiddenAbility,
        breeding = pokemon.breeding,
        genderRatio = pokemon.genderRatio;

  static createPokedex(String file) async {
    Iterable l = jsonDecode(file);
    List<Pokemon> pokemons =
        List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));
    for (var pokemon in pokemons) {
      {
        if (pokemon.forms.isNotEmpty) {
          pokemon.forms.insert(0, Pokemon.copy(pokemon, false));
        }
      }
    }
    return pokemons;
  }

  formattedTypes() {
    var union = type1.name;
    if (type2 != null) {
      String? uni = type2?.name;
      union = '$union/$uni';
    }
    return union;
  }

  findImageIndexByVariant(PokemonVariant desiredVariant) {
    String genderCode = "-mf.";
    switch (imageGender()) {
      case PokemonGender.male:
        genderCode = "-m.";
        break;
      case PokemonGender.female:
        genderCode = "-f.";
        break;
      case PokemonGender.genderless:
        genderCode = "-g.";
        break;
      case PokemonGender.undefinied:
        genderCode = "-mf.";
        break;
    }

    String variant =
        (desiredVariant == PokemonVariant.shiny) ? "-shiny-" : "-normal-";

    currentImageIndex = image.indexWhere(
        (element) => element.contains(genderCode) && element.contains(variant));

    return currentImageIndex;
  }

  findImageIndexByGender(PokemonGender desiredGender) {
    String variant = (image[currentImageIndex].contains('-normal-'))
        ? "-normal-"
        : "-shiny-";

    String genderCode;
    switch (desiredGender) {
      case PokemonGender.female:
        genderCode = "-f.";
        break;
      case PokemonGender.male:
        genderCode = "-m.";
        break;
      case PokemonGender.genderless:
        genderCode = "-g.";
        break;
      default:
        genderCode = "-mf.";
        break;
    }

    currentImageIndex = image.indexWhere(
        (element) => element.contains(genderCode) && element.contains(variant));

    return currentImageIndex;
  }

  imageGender() {
    if (image[currentImageIndex].contains('-m.')) return PokemonGender.male;

    if (image[currentImageIndex].contains('-f.')) return PokemonGender.female;

    if (image[currentImageIndex].contains('-g.')) {
      return PokemonGender.genderless;
    }

    return PokemonGender.undefinied;
  }

  imageVariant() {
    if (image[currentImageIndex].contains('-normal-')) {
      return PokemonVariant.normal;
    }

    return PokemonVariant.shiny;
  }

  imageHasGenderAlter() {
    return !(image.any((element) => element.contains('-mf')));
  }

  static Image typeImage(PokemonType? type) {
    String path = "images/types";
    switch (type) {
      case PokemonType.bug:
        return Image.asset('$path/bug.png');
      case PokemonType.dark:
        return Image.asset('$path/dark.png');
      case PokemonType.dragon:
        return Image.asset('$path/dragon.png');
      case PokemonType.electric:
        return Image.asset('$path/electric.png');
      case PokemonType.fire:
        return Image.asset('$path/fire.png');
      case PokemonType.grass:
        return Image.asset('$path/grass.png');
      case PokemonType.fairy:
        return Image.asset('$path/fairy.png');
      case PokemonType.fighting:
        return Image.asset('$path/fighting.png');
      case PokemonType.flying:
        return Image.asset('$path/flying.png');
      case PokemonType.ghost:
        return Image.asset('$path/ghost.png');
      case PokemonType.ground:
        return Image.asset('$path/ground.png');
      case PokemonType.ice:
        return Image.asset('$path/ice.png');
      case PokemonType.normal:
        return Image.asset('$path/normal.png');
      case PokemonType.poison:
        return Image.asset('$path/poison.png');
      case PokemonType.psychic:
        return Image.asset('$path/psychic.png');
      case PokemonType.rock:
        return Image.asset('$path/rock.png');
      case PokemonType.steel:
        return Image.asset('$path/steel.png');
      case PokemonType.water:
        return Image.asset('$path/water.png');
      default:
        throw ("Pokemon Type do not have a primary color defined");
    }
  }

  static Color typeColor(PokemonType type, bool isSecondaryColor) {
    switch (type) {
      case PokemonType.bug:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(132, 196, 4, 1)
            : const Color.fromRGBO(177, 218, 94, 1);
      case PokemonType.dark:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(92, 84, 100, 1)
            : const Color.fromRGBO(148, 142, 155, 1);
      case PokemonType.dragon:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(4, 115, 204, 1)
            : const Color.fromRGBO(87, 161, 221, 1);
      case PokemonType.electric:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 212, 4, 1)
            : const Color.fromRGBO(252, 227, 89, 1);
      case PokemonType.fire:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 156, 60, 1)
            : const Color.fromRGBO(252, 188, 133, 1);
      case PokemonType.grass:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(52, 196, 76, 1)
            : const Color.fromRGBO(127, 215, 139, 1);
      case PokemonType.fairy:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 159, 237, 1)
            : const Color.fromRGBO(252, 184, 244, 1);
      case PokemonType.fighting:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(228, 44, 108, 1)
            : const Color.fromRGBO(236, 116, 154, 1);
      case PokemonType.flying:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(140, 172, 228, 1)
            : const Color.fromRGBO(178, 200, 236, 1);
      case PokemonType.ghost:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(76, 108, 180, 1)
            : const Color.fromRGBO(137, 157, 205, 1);
      case PokemonType.ground:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(236, 116, 52, 1)
            : const Color.fromRGBO(236, 148, 100, 1);
      case PokemonType.ice:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(76, 212, 196, 1)
            : const Color.fromRGBO(147, 228, 220, 1);
      case PokemonType.normal:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(148, 156, 164, 1)
            : const Color.fromRGBO(182, 189, 194, 1);
      case PokemonType.poison:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(180, 100, 204, 1)
            : const Color.fromRGBO(206, 154, 223, 1);
      case PokemonType.psychic:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(252, 100, 116, 1)
            : const Color.fromRGBO(252, 150, 161, 1);
      case PokemonType.rock:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(204, 180, 132, 1)
            : const Color.fromRGBO(219, 206, 173, 1);
      case PokemonType.steel:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(92, 140, 164, 1)
            : const Color.fromRGBO(154, 186, 198, 1);
      case PokemonType.water:
        return (!isSecondaryColor)
            ? const Color.fromRGBO(52, 148, 220, 1)
            : const Color.fromRGBO(144, 196, 236, 1);
      default:
        throw ("Pokemon Type do not have a primary color defined");
    }
  }

  Game? findGameDex(String gameName, String dexName) {
    return games.firstWhereOrNull(
        (element) => element.name == gameName && element.dex == dexName);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'image': image,
  //     'number': number,
  //     'type1': type1,
  //     'type2': type2
  //   };
  // }
}
