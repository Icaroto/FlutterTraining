import 'constants.dart';

class Pokemon {
  Pokemon(this.type1, this.type2, this.image,
      {required this.name, required this.number});

  final String name;
  final String image;
  final String number;
  final PokemonType type1;
  final PokemonType? type2;

  // named constructor
  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'],
        number = json['number'],
        type1 = PokemonType.values.byName(json['type1']),
        type2 = json['type2'] == null
            ? null
            : PokemonType.values.byName(json['type2']);
  // type2 = PokemonType.values.byName(json['type2']);

  // method
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
