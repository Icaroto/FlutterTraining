import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:proto_dex/file_manager.dart';
import '../constants.dart';
import '../models/tracker.dart';
import '../models/enums.dart';
import '../models/game.dart';
import '../models/item.dart';
import '../models/pokemon.dart';

Future<List<Tracker>> getAllTrackers() async {
  List<Tracker> localTrackers = [];

  var files = await FileManager().findFiles(kTrackerPrefix, "");
  // await Future.delayed(const Duration(seconds: 2));
  for (var element in files!) {
    String content = element.readAsStringSync();
    if (content.isNotEmpty) {
      localTrackers.add(Tracker.fromJson(jsonDecode(content)));
    }
  }

  return localTrackers;
}

getTracker(String ref) {
  File file = FileManager().findFile(ref);
  String content = file.readAsStringSync();
  return Tracker.fromJson(jsonDecode(content));
}

saveTracker(Tracker tracker) {
  File file = FileManager().findFile(tracker.ref);
  var encode = jsonEncode(tracker);

  file.writeAsString(encode);
}

deleteTracker(String name) {
  FileManager().removeFile(name);
}

Tracker createTracker(
    String trackerName, String gameName, String dexName, String trackerType) {
  List<Item> pokemons = [];
  bool isShinyTracker = trackerType.contains("Shiny");
  bool isLivingDexTracker = trackerType.contains("Living");

  Tracker tracker =
      Tracker.create(trackerName, gameName, dexName, trackerType, pokemons);

  for (var pokemon in kPokedex) {
    Item? item = checkPokemon(pokemon, gameName, dexName, tracker.ref,
        isShinyTracker, isLivingDexTracker);
    if (item != null) {
      if (isLivingDexTracker) {
        if (item.hasGenderDiff()) {
          String variant =
              (trackerType.contains("Shiny")) ? "-shiny-" : "-normal-";

          Item female = Item.copy(item);
          female.gender = PokemonGender.female;
          female.displayName = "${female.name} ♀";

          female.displayImage = item.image.firstWhere(
              (img) => img.contains("-f.") && img.contains(variant));

          Item male = Item.copy(item);
          male.gender = PokemonGender.male;
          male.displayName = "${male.name} ♂";
          male.displayImage = item.image.firstWhere(
              (img) => img.contains("-m.") && img.contains(variant));

          item.forms.insert(0, male);
          item.forms.insert(1, female);
        } else if (item.forms.isNotEmpty) {
          item.forms.insert(0, Item.copy(item));
        }
      }

      pokemons.add(item);
    }
  }

  tracker.pokemons.sortBy((pokemon) => pokemon.number);

  saveTracker(tracker);

  return tracker;
}

Item? checkPokemon(Pokemon pokemon, gameName, dexName, entryOrigin,
    isShinyTracker, isLivingDexTracker) {
  Item? item;
  if (pokemon.forms.isEmpty) {
    item = createItem(pokemon, gameName, dexName, entryOrigin, isShinyTracker);
  } else {
    for (var form in pokemon.forms) {
      Item? result = checkPokemon(form, gameName, dexName, entryOrigin,
          isShinyTracker, isLivingDexTracker);
      if (result == null) continue;
      if (item == null) {
        item = result;
      } else if (isLivingDexTracker) {
        item.displayName = item.formName;
        result.displayName = result.formName;
        item.forms.add(Item.copy(result));
      }
    }
  }
  return item;
}

Item? createItem(pokemon, gameName, dexName, entryOrigin, isShinyTracker) {
  Game? game = pokemon.findGameDex(gameName, dexName);
  if (game != null) {
    if ((isShinyTracker && game.shinyLocked == "UNLOCKED") || !isShinyTracker) {
      Item item =
          Item.fromDex(pokemon, game, entryOrigin, useGameDexNumber: true);
      if (isShinyTracker) {
        item.displayImage =
            item.image.firstWhere((img) => img.contains("-shiny-"));
        item.attributes.add(PokemonAttributes.isShiny);
        for (var form in item.forms) {
          form.displayImage =
              form.image.firstWhere((img) => img.contains("-shiny-"));
          form.attributes.add(PokemonAttributes.isShiny);
        }
      }
      if (pokemon.genderRatio.genderless == "100") {
        item.gender = PokemonGender.genderless;
      } else if (pokemon.genderRatio.male == "100") {
        item.gender = PokemonGender.male;
      } else if (pokemon.genderRatio.female == "100") {
        item.gender = PokemonGender.female;
      }
      item.originalLocation = gameName;
      item.currentLocation = gameName;
      return item;
    }
  }
  return null;
}
