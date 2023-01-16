class Game extends Dex {
  Game({name, dex, required this.number, required this.notes})
      : super(name: name, dex: dex);

  final String number;
  final String notes;

  Game.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        notes = json['notes'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dex': dex,
      'number': number,
      'notes': notes,
    };
  }
}

class Dex {
  Dex({required this.name, required this.dex});

  final String name;
  final String dex;

  Dex.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        dex = json['dex'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dex': dex,
    };
  }

  static availableGames() {
    return [
      // "Pokemon Scarlet",
      // "Pokemon Violet",
      // "Pokemon Sword",
      // "Pokemon Shield",
      "Let's Go Pikachu",
      "Let's Go Eevee",
      // "Pokemon X",
      // "Pokemon Y",
      // "Pokemon Sun",
      // "Pokemon Moon",
      // "Pokemon Ultra Sun",
      // "Pokemon Ultra Moon"
    ];
  }

  static availableDex(String game) {
    List<String> dex = ["Base"];

    switch (game) {
      case "Pokemon Scarlet":
      case "Pokemon Violet":
      case "Let's Go Pikachu":
      case "Let's Go Eevee":
        dex.addAll(["Others"]);
        break;
      case "Pokemon Sword":
      case "Pokemon Shield":
        dex.addAll(["Isle of Armor", "Crown Trunda"]);
        break;
      default:
    }

    return dex;
  }

  static availableTrackerTypes() {
    return [
      "Basic",
      "Shiny Basic",
      "Living Dex",
      "Shiny Living Dex",
      "Give Me A Challenge"
    ];
  }

  getIcon() {
    String path = "images/games/";
    switch (name) {
      case "Let's Go Pikachu":
        return path += "pokemon_lets_go_pikachu.png";
      case "Let's Go Eevee":
        return path += "pokemon_lets_go_eevee.png";
      case "Pokemon Sword":
        return path += "pokemon_sword.png";
      case "Pokemon Shield":
        return path += "pokemon_shield.png";
      case "Pokemon Home":
        return path += "pokemon_home.png";
      case "Pokemon Moon":
        return path += "pokemon_moon.png";
      case "Pokemon Sun":
        return path += "pokemon_sun.png";
      case "Pokemon Ultra Moon":
        return path += "pokemon_ultra_sun.png";
      case "Pokemon Ultra Sun":
        return path += "pokemon_ultra_moon.png";
      case "Pokemon Legends: Arceus":
        return path += "pokemon_legends_arceus.png";
      case "Pokemon Omega Ruby":
        return path += "pokemon_omega_ruby.png";
      case "Pokemon Alpha Sapphire":
        return path += "pokemon_alpha_sapphire.png";
      case "Pokemon Brillian Diamond":
        return path += "pokemon_brilliant_diamond.png";
      case "Pokemon Shining Pearl":
        return path += "pokemon_shining_pearl.png";
      case "Pokemon Go":
        return path += "pokemon_go.png";
      case "Pokemon Y":
        return path += "pokemon_y.png";
      case "Pokemon X":
        return path += "pokemon_x.png";
      default:
        return path += "pokemon_not_found.png";
    }
  }
}
