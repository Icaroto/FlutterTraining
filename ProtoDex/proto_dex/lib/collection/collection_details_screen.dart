import 'package:flutter/material.dart';
import '../components/basic.dart';
import '../constants.dart';
import '../models/item.dart';
import '../models/tab.dart';
import '../components/details_header.dart';
import '../screens/details/catch_card.dart';
import '../components/type_background.dart';
import '../components/image.dart';
import '../models/pokemon.dart';
import '../components/details_panel.dart';

class CollectionDetailsPage extends StatefulWidget {
  const CollectionDetailsPage({super.key, required this.pokemon});

  final dynamic pokemon;

  @override
  State<CollectionDetailsPage> createState() => _CollectionDetailsPageState();
}

class _CollectionDetailsPageState extends State<CollectionDetailsPage> {
  var imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    //if the Pokemon object coming is a Item, we need to get its Dex information to display
    final Pokemon displayPokemon;

    if (widget.pokemon is Item) {
      String form = widget.pokemon.ref.split(".")[1];
      if (form == "0") {
        displayPokemon = kPokedex.firstWhere(
            (element) => element.number == widget.pokemon.natDexNumber);
      } else {
        displayPokemon = kPokedex
            .firstWhere(
                (element) => element.number == widget.pokemon.natDexNumber)
            .forms
            .firstWhere((pokemon) => pokemon.ref == widget.pokemon.ref);
      }
    } else {
      displayPokemon = widget.pokemon;
    }

    return Scaffold(
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
          Panel(tabs: giveMeATab(displayPokemon, widget.pokemon)),
          (widget.pokemon is Item)
              ? MainImage(imagePath: widget.pokemon.displayImage)
              : WillPopScope(
                  onWillPop: () async {
                    displayPokemon.resetImage();
                    Navigator.pop(context, false);
                    return false;
                  },
                  child:
                      MainImage(imagePath: displayPokemon.image[imageIndex])),
        ],
      ),
    );
  }

  giveMeATab(displayPokemon, originalPokemon) {
    List<PokeTab> tabs = [];
    if (originalPokemon is Item) {
      tabs.insert(
        0,
        PokeTab(
          tabName: "This Pokemon",
          leftCard: CatchInformationCard(pokemon: originalPokemon),
          rightCard: DetailsCard(
            blockTitle: "Attributes",
            cardChild: Expanded(
              child: ElevatedButton(
                onPressed: () => {},
                child: const Icon(
                  Icons.add,
                  color: Colors.redAccent,
                  size: 100,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }
}
