import 'dart:convert';

class Pokemon {
  Pokemon(this.type1, this.type2, this.image,
      {required this.species,
      required this.height,
      required this.weight,
      required this.name,
      required this.number,
      required this.forms,
      required this.games,
      required this.weakness,
      required this.abilities,
      required this.hiddenAbility});

  final String name;
  final String species;
  final String height;
  final String weight;
  final List<dynamic> image;
  final String number;
  final PokemonType type1;
  final PokemonType? type2;
  final List<Pokemon> forms;
  final List<Game> games;
  final Weakness weakness;
  final List<dynamic> abilities;
  final String hiddenAbility;
  // named constructor
  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        species = json['species'],
        height = json['height'],
        weight = json['weight'],
        image = json['image'],
        number = json['number'],
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
          quarter: json['weakness-quarter'] ?? [],
          half: json['weakness-half'] ?? [],
          double: json['weakness-double'] ?? [],
          quadruple: json['weakness-quadruple'] ?? [],
        ),
        abilities = json['abilities'],
        hiddenAbility = json['hiddenAbility'];

  static createPokemonList(String file) async {
    Iterable l = jsonDecode(file);
    List<Pokemon> pokemons =
        List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));
    for (var pokemon in pokemons) {
      {
        if (pokemon.forms.isNotEmpty) pokemon.forms.insert(0, pokemon);
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'number': number,
      'type1': type1,
      'type2': type2
    };
  }
}

class Game {
  Game({required this.name, required this.dex, required this.number});

  final String name;
  final String dex;
  final String number;

  Game.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        dex = json['dex'],
        number = json['number'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dex': dex,
      'number': number,
    };
  }

  getIcon() {
    String path = "images/games/";
    switch (name) {
      case "Let's Go Pikachu":
        path += "pokemon_lets_go_pikachu.png";
        break;
      case "Let's Go Eevee":
        path += "pokemon_lets_go_eevee.png";
        break;
      case "Sword":
        path += "pokemon_sword.png";
        break;
      case "Shield":
        path += "pokemon_shield.png";
        break;
      default:
    }
    return path;
  }
}

class Weakness {
  Weakness(
      {required this.quarter,
      required this.half,
      required this.double,
      required this.quadruple});

  final List<dynamic> quarter;
  final List<dynamic> half;
  final List<dynamic> double;
  final List<dynamic> quadruple;

  Weakness.fromJson(Map<String, dynamic> json)
      : quarter = json['quarter'],
        half = json['half'],
        double = json['double'],
        quadruple = json['quadruple'];

  Map<String, dynamic> toJson() {
    return {
      'quarter': quarter,
      'half': half,
      'double': double,
      'quadruple': quadruple,
    };
  }
}

enum PokemonType {
  bug,
  dark,
  dragon,
  electric,
  fire,
  grass,
  fairy,
  fighting,
  flying,
  ghost,
  ground,
  ice,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water,
}

enum PokemonGender {
  male,
  female,
  genderless,
}
