import 'package:flutter/material.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/enums.dart';
import '../../components/basic.dart';
import '../../models/item.dart';
import '../../models/pokemon.dart';

class CatchInformationCard extends StatefulWidget {
  const CatchInformationCard({super.key, required this.pokemon});

  final Item pokemon;
  @override
  State<CatchInformationCard> createState() => _CatchInformationCardState();
}

class _CatchInformationCardState extends State<CatchInformationCard> {
  List<Item> originalList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "Catch Info",
      cardChild: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Ball:",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  //Grid View
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          backgroundColor: Colors.black45,
                          context: context,
                          builder: (context) {
                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              childAspectRatio: 2.0,
                              children: List.generate(
                                PokeballType.values.length,
                                (index2) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.pop(context),
                                      setState(() {
                                        widget.pokemon.ball =
                                            PokeballType.values[index2];
                                      }),
                                    },
                                    child: Card(
                                      color: Colors.black,
                                      child: Image.asset(
                                        PokeballType.values[index2]
                                            .getImagePath(),
                                        height: 40,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 40,
                          child: Image.asset(
                            widget.pokemon.ball.getImagePath(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Ability:",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  //Grid View
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          backgroundColor: Colors.black45,
                          context: context,
                          builder: (context) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                List<dynamic> abilities =
                                    widget.pokemon.allAbilities();
                                return SizedBox(
                                  height: 40,
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.pop(context),
                                      setState(() {
                                        widget.pokemon.ability =
                                            abilities[index];
                                      }),
                                    },
                                    child: Center(
                                      child: Text(
                                        abilities[index],
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: widget.pokemon.allAbilities().length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(5),
                              scrollDirection: Axis.vertical,
                            );
                          },
                        )
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              widget.pokemon.ability,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Gender:",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  //Grid View
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          backgroundColor: Colors.black45,
                          context: context,
                          builder: (context) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 40,
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.pop(context),
                                      setState(() {
                                        widget.pokemon.gender =
                                            PokemonGender.values[index];
                                      }),
                                    },
                                    child: Center(
                                      child:
                                          PokemonGender.values[index].getIcon(),
                                      //  Text(
                                      //   widget.pokemon.gender.name,
                                      //   style: const TextStyle(
                                      //     fontSize: 15,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: PokemonGender.values.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(5),
                              scrollDirection: Axis.vertical,
                            );
                          },
                        )
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: widget.pokemon.gender.getIcon(),
                            //  Text(
                            //   widget.pokemon.gender.name,
                            //   style: const TextStyle(
                            //     fontSize: 15,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Level:",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  //Grid View
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          backgroundColor: Colors.black45,
                          context: context,
                          builder: (context) {
                            var levels = List<String>.generate(
                                100, (i) => (i + 1).toString());
                            levels.insert(0, kValueNotFound);
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 40,
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.pop(context),
                                      setState(() {
                                        widget.pokemon.level = levels[index];
                                      }),
                                    },
                                    child: Center(
                                      child: Text(
                                        levels[index],
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: levels.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(5),
                              scrollDirection: Axis.vertical,
                            );
                          },
                        )
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              widget.pokemon.level,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension Extensions on PokeballType {
  String getImagePath() {
    String path = "images/balls/";
    switch (this) {
      case PokeballType.pokeball:
        return "${path}pokeball.png";
      case PokeballType.greatBall:
        return "${path}greatball.png";
      case PokeballType.ultraBall:
        return "${path}ultraball.png";
      case PokeballType.masterBall:
        return "${path}masterball.png";
      case PokeballType.premierball:
        return "${path}premierball.png";
      case PokeballType.duskball:
        return "${path}duskball.png";
      case PokeballType.cherishball:
        return "${path}cherishball.png";
      case PokeballType.quickball:
        return "${path}quickball.png";
      case PokeballType.beastball:
        return "${path}beastball.png";
      case PokeballType.luxuryball:
        return "${path}luxuryball.png";
      case PokeballType.repeatball:
        return "${path}repeatball.png";
      case PokeballType.timerball:
        return "${path}timerball.png";
      case PokeballType.undefined:
        return "${path}undefined.png";
      default:
        throw Exception("-No image found for ball: $name");
    }
  }
}

extension PokemonGenderExtensions on PokemonGender {
  Icon getIcon() {
    switch (this) {
      case PokemonGender.female:
        return const Icon(
          Icons.female,
          color: Colors.redAccent,
        );
      case PokemonGender.male:
        return const Icon(
          Icons.male,
          color: Colors.blueAccent,
        );
      case PokemonGender.genderless:
        return const Icon(
          Icons.close,
          color: Colors.white,
        );
      case PokemonGender.undefinied:
        return const Icon(
          Icons.question_mark,
          color: Colors.white,
        );
    }
  }
}

extension ItemExtensions on Item {
  List<dynamic> allAbilities() {
    Pokemon dexMon = kPokedex.firstWhere((element) => element.number == number);
    List<dynamic> list = [];
    list.addAll(dexMon.abilities);
    list.add(dexMon.hiddenAbility!);
    return list;
  }
}

/*
// CatchRow(
//   title: "Ball",
//   buttonWidget: Image.asset("images/balls/greatball.png"),
//   pokemon: pokemon,
// ),
// const CatchRow(
//   title: "Ability",
//   buttonWidget: Text(
//     'This is my ability asd',
//     style: TextStyle(fontSize: 12),
//     softWrap: false,
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis, // new
//   ),
// ),
// const CatchRow(
//   title: "Gender",
//   buttonWidget: Icon(
//     Icons.female,
//     color: Colors.redAccent,
//   ),
// ),
// const CatchRow(
//   title: "Level",
//   buttonWidget: Text(
//     '100',
//     style: TextStyle(fontSize: 25),
//   ),
// ),

// class CatchRow extends StatelessWidget {
//   const CatchRow({
//     Key? key,
//     required this.title,
//     required this.buttonWidget,
//     required this.pokemon,
//   }) : super(key: key);

//   final String title;
//   final Widget buttonWidget;
//   final Item pokemon;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               "$title:",
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () => {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (context) {
//                     return Wrap(
//                       direction: Axis.horizontal,
//                       children: PokeballType.values
//                           .map(
//                             (ball) => Card(
//                               child: Image.asset(
//                                 ball.getImagePath(),
//                                 height: 40,
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     );
//                   },
//                 )
//               },
//               child: SizedBox(
//                 height: 30,
//                 // width: 30,
//                 child: Center(child: buttonWidget),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// return ListView.builder(
//   itemBuilder: (context, index) {
//     return Card(
//       // tileColor: Colors.black26,
//       child: Image.asset(
//         PokeballType.values[index].getImagePath(),
//         height: 40,
//       ),
//     );
//   },
//   itemCount: PokeballType.values.length,
//   shrinkWrap: true,
//   padding: const EdgeInsets.all(5),
//   scrollDirection: Axis.vertical,
// );
// child: DropdownButton<String>(
//   value: PokeballType.undefined.name,
//   icon: const Icon(Icons.arrow_downward),
//   elevation: 16,
//   style: const TextStyle(color: Colors.deepPurple),
//   underline: Container(
//     height: 2,
//     color: Colors.deepPurpleAccent,
//   ),
//   onChanged: (String? value) {
//     // This is called when the user selects an item.
//     setState(() {
//       pokemon.ball = PokeballType.values.byName(value!);
//     });
//   },
//   items: PokeballType.values
//       .map<DropdownMenuItem<String>>((PokeballType ball) {
//     return DropdownMenuItem<String>(
//       value: ball.name,
//       child: Text(ball.name),
//     );
//   }).toList(),
// ),




//Elevated Button
// Expanded(
//   child: ElevatedButton(
//     onPressed: () => {
//       showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10)),
//         ),
//         backgroundColor: Colors.black45,
//         context: context,
//         builder: (context) {
//           return Wrap(
//             direction: Axis.horizontal,
//             children: PokeballType.values
//                 .map(
//                   (ball) => Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius:
//                             BorderRadius.circular(10)),
//                     child: Image.asset(
//                       ball.getImagePath(),
//                       height: 70,
//                     ),
//                   ),
//                 )
//                 .toList(),
//           );
//         },
//       )
//     },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10)),
//       child: Image.asset(
//         widget.pokemon.ball.getImagePath(),
//         height: 40,
//       ),
//     ),
//   ),
// ),

//DropDown Option
// DropdownButtonHideUnderline(
//   child: Container(
//     padding: const EdgeInsets.symmetric(horizontal: 5),
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10)),
//     child: DropdownButton(
//       value: widget.pokemon.ball.name,
//       icon: const Visibility(
//         visible: false,
//         child: Icon(Icons.arrow_downward),
//       ),
//       onChanged: (String? value) {
//         setState(() {
//           widget.pokemon.ball =
//               PokeballType.values.byName(value!);
//         });
//       },
//       items:
//           PokeballType.values.map<DropdownMenuItem<String>>(
//         (PokeballType ball) {
//           return DropdownMenuItem(
//             value: ball.name,
//             child: Center(
//               child: Image.asset(
//                 ball.getImagePath(),
//                 height: 40,
//               ),
//             ),
//           );
//         },
//       ).toList(),
//     ),
//   ),
// ),

// List View Option
// Expanded(
//   child: ElevatedButton(
//     onPressed: () => {
//       showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10)),
//         ),
//         backgroundColor: Colors.black45,
//         context: context,
//         builder: (context) {
//           return ListView.builder(
//             itemBuilder: (context, index) {
//               return Card(
//                 // tileColor: Colors.black26,
//                 child: Image.asset(
//                   PokeballType.values[index].getImagePath(),
//                   height: 40,
//                 ),
//               );
//             },
//             itemCount: PokeballType.values.length,
//             shrinkWrap: true,
//             padding: const EdgeInsets.all(5),
//             scrollDirection: Axis.vertical,
//           );
//         },
//       )
//     },
//     child: Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10)),
//       child: Image.asset(
//         widget.pokemon.ball.getImagePath(),
//         height: 40,
//       ),
//     ),
//   ),
// ),
*/