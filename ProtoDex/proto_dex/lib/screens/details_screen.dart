import 'package:flutter/material.dart';
import '../components/basic.dart';
import '../constants.dart';
import '../models/item.dart';
import '../models/tab.dart';
import 'details/breeding_card.dart';
import 'details/catch_card.dart';
import 'details/details_background.dart';
import 'details/basic_info.dart';
import '../components/image.dart';
import 'details/games_card.dart';
import 'details/general_card.dart';
import 'details/lower_screen.dart';
import '../models/pokemon.dart';
import 'details/weakness_card.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.pokemon});

  final dynamic pokemon;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
        children: <Widget>[
          Background(type1: displayPokemon.type1, type2: displayPokemon.type2),
          AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          BasicInfo(
            name: displayPokemon.name,
            number: displayPokemon.number,
            type1: displayPokemon.type1,
            type2: displayPokemon.type2,
          ),
          TabControl(tabs: giveMeATab(displayPokemon, widget.pokemon)),
          MainImage(imagePath: displayPokemon.image[imageIndex]),
        ],
      ),
    );
  }

  giveMeATab(displayPokemon, originalPokemon) {
    List<PokeTab> tabs = [];
    tabs.add(
      PokeTab(
        tabName: "General",
        leftCard: GeneralInformationCard(
          pokemon: displayPokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
        rightCard: BreedingInformationCard(
          pokemon: displayPokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
      ),
    );

    tabs.add(PokeTab(
      tabName: "More",
      leftCard: GamesInformationCard(pokemon: displayPokemon),
      rightCard: WeaknessInformationCard(pokemon: displayPokemon),
    ));

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
                onPressed: () => {print("test")},
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
