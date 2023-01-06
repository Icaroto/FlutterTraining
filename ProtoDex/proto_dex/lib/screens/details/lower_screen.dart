import 'package:flutter/material.dart';
import '../../models/tab.dart';

class TabControl extends StatelessWidget {
  const TabControl({super.key, required this.tabs});

  final List<PokeTab> tabs;

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
              length: tabs.length,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TabBar(tabs: createTabs()),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(children: createContent()
                          // [
                          // Row(
                          //   children: [
                          //     CatchInformationCard(pokemon: myPokemon!),
                          //     DetailsCard(
                          //       blockTitle: "Attributes",
                          //       cardChild: Expanded(
                          //         child: ElevatedButton(
                          //           onPressed: () => {print("test")},
                          //           child: const Icon(
                          //             Icons.add,
                          //             color: Colors.redAccent,
                          //             size: 100,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // Row(
                          //   children: [
                          //     GeneralInformationCard(
                          //         pokemon: pokemon,
                          //         onImageChange: onImageChange),
                          //     BreedingInformationCard(
                          //         pokemon: pokemon,
                          //         onImageChange: onImageChange),
                          //   ],
                          // ),

                          // Row(
                          //   children: [
                          //     GamesInformationCard(pokemon: pokemon),
                          //     WeaknessInformationCard(pokemon: pokemon),
                          //   ],
                          // ),
                          // ],
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

  createTabs() {
    List<Widget> tabHeaders = [];

    for (var element in tabs) {
      tabHeaders.add(element.head());
    }

    return tabHeaders;
  }

  createContent() {
    List<Widget> tabHeaders = [];

    for (var element in tabs) {
      tabHeaders.add(element.cards());
    }

    return tabHeaders;
  }
}
