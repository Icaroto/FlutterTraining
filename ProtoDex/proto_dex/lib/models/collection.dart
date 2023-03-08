import 'dart:convert';
import 'dart:io';
import 'package:proto_dex/file_manager.dart';
import 'package:proto_dex/models/enums.dart';
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

  applyAllFilters(
      List<FilterType> filters, String? words, List<String>? types) {
    List<Item> temp = [];
    temp.addAll(pokemons.toList());

    for (var filter in filters) {
      switch (filter) {
        case FilterType.captured:
          temp = temp
              .where((element) =>
                  isPokemonCaptured(element) == CaptureType.full ||
                  isPokemonCaptured(element) == CaptureType.partial)
              .toList();
          break;
        case FilterType.notCaptured:
          temp = temp
              .where((element) =>
                  isPokemonCaptured(element) == CaptureType.empty ||
                  isPokemonCaptured(element) == CaptureType.partial)
              .toList();
          break;
        case FilterType.exclusiveOnly:
          temp = temp.where((element) => element.game.notes != "").toList();
          break;
        case FilterType.byValue:
          temp = temp
              .where((element) =>
                  element.name.toLowerCase().contains(words!.toLowerCase()))
              .toList();
          break;
        case FilterType.byType:
          if (types != null && types.isNotEmpty) {
            temp = temp
                .where((element) =>
                    containsType(types, element.type1) ||
                    containsType(types, element.type2))
                .toList();
          }
          break;
        case FilterType.numAsc:
          temp.sort((a, b) => a.number.compareTo(b.number));
          break;
        case FilterType.numDesc:
          temp.sort((a, b) => b.number.compareTo(a.number));
          break;
        case FilterType.nameAsc:
          temp.sort((a, b) => a.name.compareTo(b.name));
          break;
        case FilterType.nameDesc:
          temp.sort((a, b) => b.name.compareTo(a.name));
          break;
        default:
          return pokemons;
      }
    }

    return temp;
  }

  containsType(List<String>? values, PokemonType? type) {
    if (type == null) return false;
    return values!.contains(type.name);
  }

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
