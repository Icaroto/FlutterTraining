import 'package:flutter/material.dart';
import '../components/basic.dart';
import '../constants.dart';
import '../models/item.dart';
import '../models/tab.dart';
import '../screens/details/catch_card.dart';
import '../components/type_background.dart';
import '../components/details_header.dart';
import '../components/image.dart';
import '../models/pokemon.dart';
import '../components/details_panel.dart';

class TrackerDetailsPage extends StatefulWidget {
  const TrackerDetailsPage({
    super.key,
    required this.pokemons,
    required this.indexes,
  });

  final List<Item> pokemons;
  final List<int> indexes;

  @override
  State<TrackerDetailsPage> createState() => _TrackerDetailsPageState();
}

class _TrackerDetailsPageState extends State<TrackerDetailsPage> {
  bool isFirstInList = false;
  bool isLastInList = false;
  bool isEditable = false;
  List<int> currentIndexes = List<int>.empty(growable: true);

  @override
  void initState() {
    currentIndexes.addAll(widget.indexes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // //if the Pokemon object coming is a Item, we need to get its Dex information to display
    // final Pokemon displayPokemon;

    // if (widget.pokemon is Item) {
    //   String form = widget.pokemon.ref.split(".")[1];
    //   if (form == "0") {
    //     displayPokemon = kPokedex.firstWhere(
    //         (element) => element.number == widget.pokemon.natDexNumber);
    //   } else {
    //     displayPokemon = kPokedex
    //         .firstWhere(
    //             (element) => element.number == widget.pokemon.natDexNumber)
    //         .forms
    //         .firstWhere((pokemon) => pokemon.ref == widget.pokemon.ref);
    //   }
    // } else {
    //   displayPokemon = widget.pokemon;
    // }

    isFirstInList = widget.pokemons.isFirst(currentIndexes);
    isLastInList = widget.pokemons.isLast(currentIndexes);

    Item displayPokemon = widget.pokemons.current(currentIndexes);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: const Color(0xFF1D1E33),
        // foregroundColor: Colors.white,
        onPressed: () {
          setState(() => {
                if (isEditable)
                  {
                    isEditable = false,
                    //save to collection
                  }
                else
                  {
                    isEditable = true,
                  }
              });

          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Under Construction'),
          //   ),
          // );
        },
        child: (isEditable) ? const Icon(Icons.save) : const Icon(Icons.edit),
      ),
      body: Stack(
        children: [
          TypeBackground(
              type1: displayPokemon.type1, type2: displayPokemon.type2),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          DetailsHeader(
            name: displayPokemon.name,
            number: displayPokemon.number,
            type1: displayPokemon.type1,
            type2: displayPokemon.type2,
          ),
          Panel(tabs: giveMeATab(displayPokemon)),
          WillPopScope(
              onWillPop: () async {
                Navigator.pop(context, false);
                return false;
              },
              child: MainImage(imagePath: displayPokemon.displayImage)),
        ],
      ),
    );
  }

  giveMeATab(originalPokemon) {
    List<PokeTab> tabs = [];
    if (originalPokemon is Item) {
      tabs.insert(
        0,
        PokeTab(
          tabName: "Details",
          leftCard: CatchInformationCard(
            pokemon: originalPokemon,
            isEditable: isEditable,
          ),
          rightCard: Container(),
          // rightCard: DetailsCard(
          //   blockTitle: "Attributes",
          //   cardChild: Expanded(
          //     child: ElevatedButton(
          //       onPressed: () => {},
          //       child: const Icon(
          //         Icons.add,
          //         color: Colors.redAccent,
          //         size: 100,
          //       ),
          //     ),
          //   ),
          // ),
        ),
      );
    }
    return tabs;
  }
}
