import 'package:flutter/material.dart';
import 'package:proto_dex/models/item.dart';
import '../components/background.dart';
import '../models/collection.dart';
import 'lists/cards.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({super.key, required this.collection});

  final Collection collection;
  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  List<Item> originalList = [];
  @override
  void initState() {
    originalList.addAll(widget.collection.pokemons);
    super.initState();
  }

  TextEditingController editingController = TextEditingController();

  void filterSearchResults(String query) {
    List<Item> dummySearchList = [];
    dummySearchList.addAll(originalList);
    if (query.isNotEmpty) {
      List<Item> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        widget.collection.pokemons.clear();
        widget.collection.pokemons.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        widget.collection.pokemons.clear();
        widget.collection.pokemons.addAll(originalList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.collection.updateCollection();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
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
                Expanded(
                  child: ListView.builder(
                    itemBuilder: ((context, index) {
                      return (widget.collection.pokemons[index].forms.isEmpty)
                          ? singleCheckCard(
                              context, index, widget.collection.pokemons)
                          : multipleCheckCards(
                              context, index, widget.collection.pokemons);
                    }),
                    itemCount: widget.collection.pokemons.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
