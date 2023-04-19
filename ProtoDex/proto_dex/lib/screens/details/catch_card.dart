import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/enums.dart';
import '../../components/basic.dart';
import '../../models/game.dart';
import '../../models/item.dart';
import '../../models/pokemon.dart';

class CatchInformationCard extends StatefulWidget {
  const CatchInformationCard({
    super.key,
    required this.pokemon,
    this.isEditable = false,
  });

  final Item pokemon;
  final bool isEditable;
  @override
  State<CatchInformationCard> createState() => _CatchInformationCardState();
}

class _CatchInformationCardState extends State<CatchInformationCard> {
  List<Item> originalList = [];
  @override
  void initState() {
    super.initState();
  }

  List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  List<String> _selectedOptions = [];

  void _showMultiSelect(BuildContext context) async {
    _selectedOptions = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select options'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _options.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(_options[index]),
                    value: _selectedOptions.contains(_options[index]),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          _selectedOptions.add(_options[index]);
                        } else {
                          _selectedOptions.remove(_options[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_selectedOptions);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      blockTitle: "",
      cardChild: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  //BALL
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Image.network(
                            widget.pokemon.ball.getImagePath(),
                          ),
                        ),
                        const ItemName(text: 'ball')
                      ],
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
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
                                  child: Image.network(
                                    PokeballType.values[index2].getImagePath(),
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),

                  //ABILITY
                  // const ItemName(text: "Ability"),
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: FittedBox(
                        child: Column(
                      children: [
                        Text(
                          widget.pokemon.ability,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                        const ItemName(text: "Ability"),
                      ],
                    )),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
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
                                    widget.pokemon.ability = abilities[index];
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
                      });
                    },
                  ),

                  // LEVEL
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          Text(
                            widget.pokemon.level,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                          const ItemName(text: "Level"),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
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
                      });
                    },
                  ),

                  // GENDER
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: widget.pokemon.gender.getIcon(),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
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
                                  child: PokemonGender.values[index].getIcon(),
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
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  //Catch Date
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          const ItemName(text: "Captured:"),
                          Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(widget
                                .pokemon
                                .catchDate)), //format(widget.pokemon.catchDate),
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      DateTime? date = await bottomDatePicker(context);
                      widget.pokemon.catchDate = date.toString();
                      setState(() {});
                    },
                  ),
                  //OT
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          const ItemName(text: "OT"),
                          Text(
                            widget.pokemon.trainerName,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      setState(() {});
                    },
                  ),
                  //Method
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: FittedBox(
                      child: Column(
                        children: [
                          const ItemName(text: "Method"),
                          Text(
                            widget.pokemon.capturedMethod.name,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  //Origin Game
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Image.network(
                            kImageLocalPrefix +
                                Game.gameIcon(widget.pokemon.origin),
                            height: 40,
                          ),
                        ),
                        const ItemName(text: 'Origin')
                      ],
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                          children: List.generate(
                            Dex.allGames().length,
                            (index2) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.origin =
                                        Dex.allGames()[index2];
                                  }),
                                },
                                child: Card(
                                  color: Colors.black,
                                  child: Image.network(
                                    kImageLocalPrefix +
                                        Game.gameIcon(Dex.allGames()[index2]),
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),

                  //Current Location
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          child: Image.network(
                            kImageLocalPrefix +
                                Game.gameIcon(widget.pokemon.currentLocation),
                            height: 40,
                          ),
                        ),
                        const FittedBox(child: ItemName(text: 'Currently'))
                      ],
                    ),
                    onPressed: () async {
                      bottomSheetOptions(context, (context) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 2.0,
                          children: List.generate(
                            Dex.allGames().length,
                            (index2) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.pop(context),
                                  setState(() {
                                    widget.pokemon.currentLocation =
                                        Dex.allGames()[index2];
                                  }),
                                },
                                child: Card(
                                  color: Colors.black,
                                  child: Image.network(
                                    kImageLocalPrefix +
                                        Game.gameIcon(Dex.allGames()[index2]),
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  EditableButton(
                    isEditable: widget.isEditable,
                    currentValue: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        ItemName(text: 'Attributes'),
                        Icon(
                          Icons.add,
                          size: 50,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      _showMultiSelect(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Expanded(
      //   child: Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // children: [
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   child: Row(
      //     children: [
      //       // const Expanded(
      //       //   child: Text(
      //       //     "Ball:",
      //       //     style: TextStyle(color: Colors.white),
      //       //   ),
      //       // ),
      //       //Grid View
      //       GestureDetector(
      //         onTap: () => {
      //           showModalBottomSheet(
      //             shape: const RoundedRectangleBorder(
      //               borderRadius: BorderRadius.only(
      //                   topLeft: Radius.circular(10),
      //                   topRight: Radius.circular(10)),
      //             ),
      //             backgroundColor: Colors.black45,
      //             context: context,
      //             builder: (context) {
      //               return GridView.count(
      //                 shrinkWrap: true,
      //                 crossAxisCount: 3,
      //                 childAspectRatio: 2.0,
      //                 children: List.generate(
      //                   PokeballType.values.length,
      //                   (index2) {
      //                     return GestureDetector(
      //                       onTap: () => {
      //                         Navigator.pop(context),
      //                         setState(() {
      //                           widget.pokemon.ball =
      //                               PokeballType.values[index2];
      //                         }),
      //                       },
      //                       child: Card(
      //                         color: Colors.black,
      //                         child: Image.network(
      //                           PokeballType.values[index2]
      //                               .getImagePath(),
      //                           height: 40,
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                 ),
      //               );
      //             },
      //           )
      //         },
      //         child: Container(
      //           padding: const EdgeInsets.symmetric(horizontal: 5),
      //           decoration: BoxDecoration(
      //               color: (widget.isEditable)
      //                   ? Colors.black26
      //                   : Colors.transparent,
      //               borderRadius: BorderRadius.circular(10)),
      //           child: SizedBox(
      //             height: 40,
      //             child: Image.network(
      //               widget.pokemon.ball.getImagePath(),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   child: Row(
      //     children: [
      //       const Expanded(
      //         child: Text(
      //           "Ability:",
      //           style: TextStyle(color: Colors.white),
      //         ),
      //       ),
      //       //Grid View
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () => {
      //             showModalBottomSheet(
      //               shape: const RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(10),
      //                     topRight: Radius.circular(10)),
      //               ),
      //               backgroundColor: Colors.black45,
      //               context: context,
      //               builder: (context) {
      //                 return ListView.builder(
      //                   itemBuilder: (context, index) {
      //                     List<dynamic> abilities =
      //                         widget.pokemon.allAbilities();
      //                     return SizedBox(
      //                       height: 40,
      //                       child: GestureDetector(
      //                         onTap: () => {
      //                           Navigator.pop(context),
      //                           setState(() {
      //                             widget.pokemon.ability =
      //                                 abilities[index];
      //                           }),
      //                         },
      //                         child: Center(
      //                           child: Text(
      //                             abilities[index],
      //                             style: const TextStyle(
      //                               fontSize: 30,
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                   itemCount: widget.pokemon.allAbilities().length,
      //                   shrinkWrap: true,
      //                   padding: const EdgeInsets.all(5),
      //                   scrollDirection: Axis.vertical,
      //                 );
      //               },
      //             )
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 5),
      //             decoration: BoxDecoration(
      //                 color: Colors.black38,
      //                 borderRadius: BorderRadius.circular(10)),
      //             child: SizedBox(
      //               height: 40,
      //               child: Center(
      //                 child: Text(
      //                   widget.pokemon.ability,
      //                   style: const TextStyle(
      //                     fontSize: 15,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   child: Row(
      //     children: [
      //       const Expanded(
      //         child: Text(
      //           "Gender:",
      //           style: TextStyle(color: Colors.white),
      //         ),
      //       ),
      //       //Grid View
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () => {
      //             showModalBottomSheet(
      //               shape: const RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(10),
      //                     topRight: Radius.circular(10)),
      //               ),
      //               backgroundColor: Colors.black45,
      //               context: context,
      //               builder: (context) {
      //                 return ListView.builder(
      //                   itemBuilder: (context, index) {
      //                     return SizedBox(
      //                       height: 40,
      //                       child: GestureDetector(
      //                         onTap: () => {
      //                           Navigator.pop(context),
      //                           setState(() {
      //                             widget.pokemon.gender =
      //                                 PokemonGender.values[index];
      //                           }),
      //                         },
      //                         child: Center(
      //                           child:
      //                               PokemonGender.values[index].getIcon(),
      //                           //  Text(
      //                           //   widget.pokemon.gender.name,
      //                           //   style: const TextStyle(
      //                           //     fontSize: 15,
      //                           //     color: Colors.white,
      //                           //   ),
      //                           // ),
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                   itemCount: PokemonGender.values.length,
      //                   shrinkWrap: true,
      //                   padding: const EdgeInsets.all(5),
      //                   scrollDirection: Axis.vertical,
      //                 );
      //               },
      //             )
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 5),
      //             decoration: BoxDecoration(
      //                 color: Colors.black38,
      //                 borderRadius: BorderRadius.circular(10)),
      //             child: SizedBox(
      //               height: 40,
      //               child: Center(
      //                 child: widget.pokemon.gender.getIcon(),
      //                 //  Text(
      //                 //   widget.pokemon.gender.name,
      //                 //   style: const TextStyle(
      //                 //     fontSize: 15,
      //                 //     color: Colors.white,
      //                 //   ),
      //                 // ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //   child: Row(
      //     children: [
      //       const Expanded(
      //         child: Text(
      //           "Level:",
      //           style: TextStyle(color: Colors.white),
      //         ),
      //       ),
      //       //Grid View
      //       Expanded(
      //         child: GestureDetector(
      //           onTap: () => {
      //             showModalBottomSheet(
      //               shape: const RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(10),
      //                     topRight: Radius.circular(10)),
      //               ),
      //               backgroundColor: Colors.black45,
      //               context: context,
      //               builder: (context) {
      //                 var levels = List<String>.generate(
      //                     100, (i) => (i + 1).toString());
      //                 levels.insert(0, kValueNotFound);
      //                 return ListView.builder(
      //                   itemBuilder: (context, index) {
      //                     return SizedBox(
      //                       height: 40,
      //                       child: GestureDetector(
      //                         onTap: () => {
      //                           Navigator.pop(context),
      //                           setState(() {
      //                             widget.pokemon.level = levels[index];
      //                           }),
      //                         },
      //                         child: Center(
      //                           child: Text(
      //                             levels[index],
      //                             style: const TextStyle(
      //                               fontSize: 30,
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     );
      //                   },
      //                   itemCount: levels.length,
      //                   shrinkWrap: true,
      //                   padding: const EdgeInsets.all(5),
      //                   scrollDirection: Axis.vertical,
      //                 );
      //               },
      //             )
      //           },
      //           child: Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 5),
      //             decoration: BoxDecoration(
      //                 color: Colors.black38,
      //                 borderRadius: BorderRadius.circular(10)),
      //             child: SizedBox(
      //               height: 40,
      //               child: Center(
      //                 child: Text(
      //                   widget.pokemon.level,
      //                   style: const TextStyle(
      //                     fontSize: 15,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // ],
      //       ),
      // ),
    );
  }
}

class ItemName extends StatelessWidget {
  const ItemName({
    required this.text,
    super.key,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.amber,
        // fontSize: 12,
      ),
    );
  }
}

class EditableButton extends StatelessWidget {
  const EditableButton({
    super.key,
    required this.isEditable,
    required this.currentValue,
    required this.onPressed,
  });

  final bool isEditable;
  final Widget currentValue;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: (isEditable) ? onPressed : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: (isEditable)
              ? BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.yellow))
              : null,
          child: SizedBox(child: Center(child: currentValue)),
        ),
      ),
    );
  }
}

Future<DateTime?> bottomDatePicker(BuildContext context) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: DateTime.now().subtract(Duration(days: 1)),
    firstDate: DateTime(2021),
    lastDate: DateTime(2050),
  );
  return date;
}

Future<dynamic> bottomSheetOptions(
  BuildContext context,
  Widget Function(BuildContext) builder,
) {
  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    backgroundColor: Colors.black45,
    context: context,
    builder: builder,
  );
}

extension Extensions on PokeballType {
  String getImagePath() {
    switch (this) {
      case PokeballType.pokeball:
        return "${kImageLocalPrefix}balls/pokeball.png";
      case PokeballType.greatBall:
        return "${kImageLocalPrefix}balls/greatball.png";
      case PokeballType.ultraBall:
        return "${kImageLocalPrefix}balls/ultraball.png";
      case PokeballType.masterBall:
        return "${kImageLocalPrefix}balls/masterball.png";
      case PokeballType.premierball:
        return "${kImageLocalPrefix}balls/premierball.png";
      case PokeballType.duskball:
        return "${kImageLocalPrefix}balls/duskball.png";
      case PokeballType.cherishball:
        return "${kImageLocalPrefix}balls/cherishball.png";
      case PokeballType.quickball:
        return "${kImageLocalPrefix}balls/quickball.png";
      case PokeballType.beastball:
        return "${kImageLocalPrefix}balls/beastball.png";
      case PokeballType.luxuryball:
        return "${kImageLocalPrefix}balls/luxuryball.png";
      case PokeballType.repeatball:
        return "${kImageLocalPrefix}balls/repeatball.png";
      case PokeballType.timerball:
        return "${kImageLocalPrefix}balls/timerball.png";
      case PokeballType.undefined:
        return "${kImageLocalPrefix}balls/undefined.png";
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
    Pokemon dexMon =
        kPokedex.firstWhere((element) => element.number == natDexNumber);
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
