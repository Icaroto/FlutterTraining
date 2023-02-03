import 'dart:convert';
import 'dart:io';
import 'package:proto_dex/file_manager.dart';
import 'item.dart';

class Collection {
  String name;
  String game;
  String dex;
  String type;
  List<Item> pokemons;

  Collection.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        game = json['game'],
        dex = json['dex'],
        type = json['type'],
        pokemons = json['pokemons'] != null
            ? List<Item>.from(
                json['pokemons'].map((model) => Item.fromJson(model)))
            : [];

  Collection.create(String gameName, String dexName, String trackerType,
      List<Item> pokemonList)
      : name = "tracker_${gameName}_${dexName}_$trackerType"
            .replaceAll(" ", "")
            .replaceAll("'", "")
            .toLowerCase(),
        game = gameName,
        dex = dexName,
        type = trackerType,
        pokemons = pokemonList;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'game': game,
      'dex': dex,
      'type': type,
      'pokemons': pokemons.map((i) => i.toJson()).toList(),
    };
  }

  total() {
    var count = pokemons.where((element) => element.forms.isEmpty).length;

    pokemons
        .where((element) => element.forms.isNotEmpty)
        .toList()
        .forEach((element) {
      count += element.forms.length;
    });

    return count.toString();
    // return pokemons.length.toString();
  }

  capturedTotal() {
    var count = pokemons
        .where((element) => element.forms.isEmpty && element.captured == true)
        .length;

    pokemons
        .where((element) => element.forms.isNotEmpty)
        .toList()
        .forEach((pokemon) {
      count += pokemon.forms.where((form) => form.captured == true).length;
    });

    return count.toString();
  }

  missingTotal() {
    var count = pokemons
        .where((element) => element.forms.isEmpty && element.captured == false)
        .length;

    pokemons
        .where((element) => element.forms.isNotEmpty)
        .toList()
        .forEach((pokemon) {
      count += pokemon.forms.where((form) => form.captured == false).length;
    });

    return count.toString();
  }

  percentage() {
    var perc =
        (pokemons.where((element) => element.captured == true).toList().length /
                pokemons.length) *
            100;

    return perc.toStringAsFixed(2);
  }

  findCollection(String fileName) {
    List<Collection> collections = [];

    File collectionsFile = FileManager().findFile(fileName);
    String content = collectionsFile.readAsStringSync();

    if (content.isNotEmpty) {
      Iterable l = jsonDecode(content);
      collections =
          List<Collection>.from(l.map((model) => Collection.fromJson(model)));
    }

    return collections;
  }

  updateCollection() {
    List<Collection> collections = findCollection(name);
    collections.clear();
    collections.add(this);
    collections.saveToFile(name);
  }

  filterCollection(FilterType filter, {String value = ""}) {
    switch (filter) {
      case FilterType.captured:
        return pokemons
            .where((element) =>
                isPokemonCaptured(element) == CaptureType.full ||
                isPokemonCaptured(element) == CaptureType.partial)
            .toList();
      case FilterType.notCaptured:
        return pokemons
            .where((element) =>
                isPokemonCaptured(element) == CaptureType.empty ||
                isPokemonCaptured(element) == CaptureType.partial)
            .toList();
      case FilterType.exclusiveOnly:
        return pokemons.where((element) => element.game.notes != "").toList();
      case FilterType.byValue:
        return pokemons.where((element) =>
            element.name.toLowerCase().contains(value.toLowerCase()));
      case FilterType.all:
      default:
        return pokemons;
    }
  }

  //check if all forms are captured to say a pokemon is captured
  // isPokemonCaptured(Item pokemon) {
  //   if (pokemon.forms.isNotEmpty) {
  //     return pokemon.forms.every((element) => element.captured == true);
  //   } else {
  //     return pokemon.captured;
  //   }
  // }

  CaptureType isPokemonCaptured(Item pokemon) {
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

  static CaptureType keepTabOpen(Item pokemon) {
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

enum FilterType { captured, notCaptured, all, exclusiveOnly, byValue }

enum CaptureType { full, partial, empty }
// extension Utils on Collection {
//   updateCollection() {
//     String fileName = name;
//     List<Collection> collections = <Collection>[].findCollection(fileName);
//     collections.clear();
//     collections.add(this);
//     collections.saveToFile(fileName);
//   }
// }

extension CollectionsExtensions on List<Collection> {
  Future<List<Collection>> findCollections() async {
    List<Collection> collections = [];

    var files = await FileManager().findFiles("tracker_", "");
    await Future.delayed(const Duration(seconds: 2));
    for (var element in files!) {
      String content = element.readAsStringSync();
      if (content.isNotEmpty) {
        Iterable l = jsonDecode(content);
        collections.addAll(List<Collection>.from(
            l.map((model) => Collection.fromJson(model))));
      }
    }

    return collections;
  }

  findCollection(String fileName) {
    List<Collection> collections = [];

    File collectionsFile = FileManager().findFile(fileName);
    String content = collectionsFile.readAsStringSync();

    if (content.isNotEmpty) {
      Iterable l = jsonDecode(content);
      collections =
          List<Collection>.from(l.map((model) => Collection.fromJson(model)));
    }

    return collections;
  }

  saveToFile(String fileName) {
    File file = FileManager().findFile(fileName);

    var toJson = map((i) => i.toJson()).toList();
    var encode = jsonEncode(toJson);

    file.writeAsString(encode);
  }
}
