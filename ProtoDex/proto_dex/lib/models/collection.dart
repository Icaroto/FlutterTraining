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
}

extension Utils on Collection {
  updateCollection() {
    String fileName = name;
    List<Collection> collections = <Collection>[].findCollection(fileName);
    collections.clear();
    collections.add(this);
    collections.saveToFile(fileName);
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
