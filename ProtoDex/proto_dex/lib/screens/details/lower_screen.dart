import 'package:flutter/material.dart';
import 'catch_card.dart';
import '../../models/item.dart';
import 'breeding_card.dart';
import 'games_card.dart';
import 'general_card.dart';
import 'weakness_card.dart';
import '../../models/pokemon.dart';

class PokeInfoCard extends StatelessWidget {
  const PokeInfoCard(
      {super.key,
      required this.pokemon,
      required this.onImageChange,
      this.myPokemon});

  final Pokemon pokemon;
  final Function(int) onImageChange;
  final Item? myPokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(),
        ),
        const SizedBox(height: 100),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1.5,
                  spreadRadius: 1.5,
                  offset: Offset(2, 0),
                  blurStyle: BlurStyle.inner,
                ),
              ],
              color: Color.fromARGB(255, 48, 57, 67),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
                bottom: Radius.circular(0),
              ),
            ),
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const TabBar(tabs: [
                    Tab(text: "Details"),
                    Tab(text: "More"),
                    // Tab(text: "Useful"),
                  ]),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          Row(
                            children: [
                              CatchInformationCard(pokemon: myPokemon!),
                              GeneralInformationCard(
                                  pokemon: pokemon,
                                  onImageChange: onImageChange),
                              // BreedingInformationCard(
                              //     pokemon: pokemon,
                              //     onImageChange: onImageChange),
                            ],
                          ),
                          Row(
                            children: [
                              GamesInformationCard(pokemon: pokemon),
                              WeaknessInformationCard(pokemon: pokemon),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
