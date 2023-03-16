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
  //TODO: Check if is better to leave as "when added";
  collection.sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
  saveCollection(collection);
}

saveCollection(List<Item> collection) {
  File file = FileManager().findFile(kCollectionBaseName);
  var encode = jsonEncode(collection);

  file.writeAsString(encode);
}

createGroupByDexNumber(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.natDexNumber);
  for (var map in newMap.entries) {
    Group group = Group(name: map.key, items: map.value);
    groups.add(group);
  }
  return groups;
}

createGroupByPokemon(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.natDexNumber);
  for (var map in newMap.entries) {
    Group group = Group(name: map.value.first.name, items: map.value);
    group.items.sortBy((element) => element.ref);
    groups.add(group);
  }
  return groups;
}

createGroupByGame(List<Item> collection) {
  List<Group> groups = [];
  var newMap = groupBy(collection, (Item obj) => obj.game.name);
  for (var map in newMap.entries) {
    Group group = Group(name: map.key, items: map.value);
    group.items.sortBy((element) => element.number);
    group.color = Game.gameColor(group.name);
    // group.image = Game.gameIcon(group.name);
    groups.add(group);
  }
  return groups;
}
