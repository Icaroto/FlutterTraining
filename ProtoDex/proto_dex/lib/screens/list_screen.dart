import 'package:flutter/material.dart';
import 'package:proto_dex/styles.dart';
import '../models/collection.dart';
import '../models/item.dart';
import '../models/pokemon.dart';
import 'lists/cards.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, this.pokemons, this.collection});

  final List<Pokemon>? pokemons;
  final Collection? collection;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Pokemon> originalPokedex = [];
  List<Item> originalCollection = [];
  @override
  void initState() {
    if (widget.pokemons != null) originalPokedex.addAll(widget.pokemons!);
    if (widget.collection != null) {
      originalCollection.addAll(widget.collection!.pokemons);
    }
    super.initState();
  }

  TextEditingController editingController = TextEditingController();

  void filterSearchResults(String query) {
    if (originalPokedex.isNotEmpty) {
      List<Pokemon> dummySearchList = [];
      dummySearchList.addAll(originalPokedex);
      if (query.isNotEmpty) {
        List<Pokemon> dummyListData = [];
        for (var item in dummySearchList) {
          if (item.name.toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }
        setState(() {
          widget.pokemons!.clear();
          widget.pokemons!.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          widget.pokemons!.clear();
          widget.pokemons!.addAll(originalPokedex);
        });
      }
    } else {
      List<Item> dummySearchList = [];
      dummySearchList.addAll(originalCollection);
      if (query.isNotEmpty) {
        List<Item> dummyListData = [];
        for (var item in dummySearchList) {
          if (item.name.toLowerCase().contains(query.toLowerCase())) {
            dummyListData.add(item);
          }
        }
        setState(() {
          widget.collection!.pokemons.clear();
          widget.collection!.pokemons.addAll(dummyListData);
        });
        return;
      } else {
        setState(() {
          widget.collection!.pokemons.clear();
          widget.collection!.pokemons.addAll(originalCollection);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: (widget.pokemons == null)
          ? FloatingActionButton(
              onPressed: () {
                widget.collection!.updateCollection();
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.save),
            )
          : null,
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    // const BackButton(color: Colors.white),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            filterSearchResults(value);
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            labelText: "Search",
                            hintText: "Search",
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                giveMeAList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded giveMeAList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: ((context, index) {
          if (widget.pokemons != null) {
            return (widget.pokemons![index].forms.isEmpty)
                ? singleCard(context, index, widget.pokemons)
                : multipleCards(context, index, widget.pokemons);
          } else {
            print("It's item");
            return (widget.collection!.pokemons[index].forms.isEmpty)
                ? singleCard(context, index, widget.collection?.pokemons)
                : multipleCards(context, index, widget.collection!.pokemons);
          }
        }),
        itemCount: (widget.pokemons != null)
            ? widget.pokemons!.length
            : widget.collection!.pokemons.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
