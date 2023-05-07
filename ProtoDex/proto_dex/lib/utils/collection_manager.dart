import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:proto_dex/file_manager.dart';
import '../constants.dart';
import '../models/game.dart';
import '../models/group.dart';
import '../models/item.dart';

getCollection() {
  File file = FileManager().findFile(kCollectionBaseName);
  String content = file.readAsStringSync();
  if (content.isEmpty) return List<Item>.empty(growable: true);
  return List<Item>.from(
      (jsonDecode(content)).map((model) => Item.fromJson(model)));
}

addItemsToCollection(List<Item> items) {
  List<Item> collection = getCollection();
  List<Item> toAddToCollection = [];
  for (var item in items) {
    if (item.forms.isEmpty) {
      toAddToCollection.add(item);
    } else {
      item.forms.removeWhere((element) => element.captured == false);
      toAddToCollection.addAll(item.forms);
    }
  }

  for (var pokemon in toAddToCollection) {
    collection.removeWhere((element) =>
        element.ref == pokemon.ref && element.origin == pokemon.origin);
    collection.add(pokemon);
  }
  collection.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
  saveCollection(collection);
}

saveCollection(List<Item> collection) {
  File file = FileManager().findFile(kCollectionBaseName);
  var encode = jsonEncode(collection);

  file.writeAsString(encode);
}

groupByPokemon(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.natDexNumber);
  for (var map in newMap.entries) {
    Group group = Group(
        name: map.value.first.name,
        items: map.value,
        image: 'mons/${map.value.first.displayImage}');
    group.items.sortBy((element) => element.ref);
    groups.add(group);
  }
  return groups;
}

groupByGame(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.currentLocation);
  for (var map in newMap.entries) {
    Group group =
        Group(name: map.key, items: map.value, image: Game.gameIcon(map.key));
    group.items.sortBy((element) => element.number);
    group.color = Game.gameColor(group.name);
    groups.add(group);
  }
  return groups;
}
