import 'dart:convert';

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

class Pokemon {
  Pokemon(this.type1, this.type2, this.image, this.species,
      {required this.name,
      required this.number,
      required this.forms,
      required this.games});

  final String name;
  final String species;
  final List<dynamic> image;
  final String number;
  final PokemonType type1;
  final PokemonType? type2;
  final List<Pokemon> forms;
  final List<Game> games;

  // named constructor
  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        species = json['species'],
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
            : [];

  static createPokemonList(String file) async {
    // final String rawJson = await rootBundle.loadString('data/pokedex.json');
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

  abilities() {
    return <String>() {
      "d";
      "d";
      "d";
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'number': number,
      'type1': type1,
      'type2': type2
    };
  }

  // loadForms(forms) async {
  //   final String rawJson = await rootBundle.loadString('data/pokedex.json');
  //   Iterable l = jsonDecode(forms);
  //   return List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));
  // }
}

class Game {
  Game({required this.name, required this.number});

  final String name;
  final String number;

  Game.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        number = json['number'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
    };
  }

  // loadForms(forms) async {
  //   final String rawJson = await rootBundle.loadString('data/pokedex.json');
  //   Iterable l = jsonDecode(forms);
  //   return List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));
  // }
}
