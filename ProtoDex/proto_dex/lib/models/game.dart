class Game extends Dex {
  Game({name, dex, required this.number}) : super(name: name, dex: dex);

  final String number;

  Game.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dex': dex,
      'number': number,
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

  static availableDexes() {
    return [
      Dex(name: "Let's Go Pikachu", dex: "Base"),
      Dex(name: "Let's Go Eevee", dex: "Base"),
      Dex(name: "Pokemon Sword", dex: "Base"),
      Dex(name: "Pokemon Sword", dex: "The Isle of Armor"),
      Dex(name: "Pokemon Sword", dex: "The Crown Tundra"),
      Dex(name: "Pokemon Shield", dex: "Base"),
      Dex(name: "Pokemon Shield", dex: "The Isle of Armor"),
      Dex(name: "Pokemon Shield", dex: "The Crown Tundra"),
      // Dex(name: "Pokemon Ultra Moon", dex: "Base"),
    ];
  }

  static availableGames() {
    return [
      "Pokemon Scarlet",
      "Pokemon Violet",
      "Let's Go Pikachu",
      "Let's Go Eevee",
      "Pokemon Sword",
      "Pokemon Shield"
    ];
  }

  static availableDex(String game) {
    List<String> dex = ["Regional"];

    switch (game) {
      case "Pokemon Scarlet":
      case "Pokemon Violet":
      case "Let's Go Pikachu":
      case "Let's Go Eevee":
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
