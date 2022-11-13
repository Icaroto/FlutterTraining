import 'dart:convert';
import 'dart:io';

import 'package:proto_dex/file_manager.dart';

import 'item.dart';

class Collection {
  final String game;
  final String dex;
  final List<Item> pokemons;

  Collection.fromJson(Map<String, dynamic> json)
      : game = json['game'],
        dex = json['dex'],
        pokemons = json['pokemons'] != null
            ? List<Item>.from(
                json['pokemons'].map((model) => Item.fromJson(model)))
            : [];

  Collection.create(String gameName, String dexName, List<Item> pokemonList)
      : game = gameName,
        dex = dexName,
        pokemons = pokemonList;

  Map<String, dynamic> toJson() {
    return {
      'game': game,
      'dex': dex,
      'pokemons': pokemons.map((i) => i.toJson()).toList(),
    };
  }
}

extension Utils on Collection {
  updateCollection() {
    String fileName = "${game}_$dex";
    List<Collection> collections = <Collection>[].findCollection(fileName);
    collections.clear();
    collections.add(this);
    collections.saveToFile(fileName);
  }
}

extension CollectionsExtensions on List<Collection> {
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
