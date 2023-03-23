import 'package:flutter/material.dart';
import '../models/tab.dart';
import '../screens/details/breeding_card.dart';
import '../screens/details/details_background.dart';
import '../screens/details/basic_info.dart';
import '../components/image.dart';
import '../screens/details/games_card.dart';
import '../screens/details/general_card.dart';
import '../screens/details/lower_screen.dart';
import '../models/pokemon.dart';
import '../screens/details/weakness_card.dart';

class PokedexDetailsPage extends StatefulWidget {
  const PokedexDetailsPage(
      {super.key, required this.pokemons, required this.indexes});

  final List<Pokemon> pokemons;
  final List<int> indexes;

  @override
  State<PokedexDetailsPage> createState() => _PokedexDetailsPage();
}

class _PokedexDetailsPage extends State<PokedexDetailsPage> {
  int imageIndex = 0;
  // int displayIndex = 0;
  // int formIndex = 0;
  List<int> currentIndexes = List<int>.empty(growable: true);
  @override
  void initState() {
    currentIndexes.addAll(widget.indexes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Pokemon pokemon = widget.pokemons.current(currentIndexes);
    // Pokemon pokemon = widget.pokemons[displayIndex];
    // for (var i = 1; i < widget.indexes.length; i++) {
    //   pokemon = pokemon.forms[widget.indexes[i]];
    // }

    return Scaffold(
      body: Stack(
        children: [
          Background(type1: pokemon.type1, type2: pokemon.type2),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          BasicInfo(
            name: pokemon.name,
            number: pokemon.number,
            type1: pokemon.type1,
            type2: pokemon.type2,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: null,
                    // onPressed: (displayIndex > 0)
                    //     ? () => {
                    //           setState(() {
                    //             if (widget.pokemons[displayIndex - 1].forms
                    //                     .isNotEmpty &&
                    //                 formIndex == 0) {
                    //               formIndex = widget.pokemons[displayIndex - 1]
                    //                       .forms.length -
                    //                   1;
                    //               displayIndex--;
                    //             } else if (formIndex > 0) {
                    //               formIndex--;
                    //             } else {
                    //               displayIndex--;
                    //             }
                    //             imageIndex = 0;
                    //             pokemon.resetImage();
                    //           }),
                    //         }
                    //     : null,
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        imageIndex = 0;
                        pokemon.resetImage();
                        currentIndexes =
                            widget.pokemons.nextIndex(currentIndexes);
                      }),
                    },
                    // onPressed: (displayIndex < widget.pokemons.length)
                    //     ? () => {
                    //           setState(() {
                    //             if (formIndex <
                    //                 widget.pokemons[displayIndex].forms.length -
                    //                     1) {
                    //               formIndex++;
                    //             } else {
                    //               displayIndex++;
                    //               formIndex = 0;
                    //             }
                    //             imageIndex = 0;
                    //             pokemon.resetImage();
                    //           }),
                    //         }
                    //     : null,
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TabControl(tabs: buildTab(pokemon)),
          WillPopScope(
              onWillPop: () async {
                imageIndex = 0;
                Navigator.pop(context, false);
                return false;
              },
              child: MainImage(imagePath: pokemon.image[imageIndex])),
        ],
      ),
    );
  }

  buildTab(Pokemon pokemon) {
    List<PokeTab> tabs = [];
    tabs.add(
      PokeTab(
        tabName: "General",
        leftCard: GeneralInformationCard(
          pokemon: pokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
        rightCard: BreedingInformationCard(
          pokemon: pokemon,
          onImageChange: (int newIndex) {
            setState(() => imageIndex = newIndex);
          },
        ),
      ),
    );

    tabs.add(PokeTab(
      tabName: "More",
      leftCard: GamesInformationCard(pokemon: pokemon),
      rightCard: WeaknessInformationCard(pokemon: pokemon),
    ));

    return tabs;
  }
}
