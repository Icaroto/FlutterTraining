import 'package:flutter/material.dart';
import '../components/pokemon.dart';

class PokeInfoCard extends StatelessWidget {
  const PokeInfoCard(
      {super.key,
      required this.pokemon,
      required this.imageIndex,
      required this.onImageChange});

  final Pokemon pokemon;
  final Function(int) onImageChange;
  final int imageIndex;

  isCurrentImageShiny() {
    return pokemon.image[imageIndex].contains('-shiny-');
  }

  hasGenderDiff() {
    return !(pokemon.image.any((element) => element.contains('-mf')));
  }

  currentColor() {
    if (pokemon.image[imageIndex].contains('-shiny-')) return "shiny";
    return "normal";
  }

  findImageIndexBasedOnString(code) {
    String gender = "";
    if ((pokemon.image[imageIndex].contains('-f.'))) {
      gender = "-f";
    } else if ((pokemon.image[imageIndex].contains('-m.'))) {
      gender = "-m";
    } else if ((pokemon.image[imageIndex].contains('-g.'))) {
      gender = "-g";
    }
    String color = (isCurrentImageShiny()) ? "-shiny-" : "-normal-";

    if (code == gender || code == color) return imageIndex;

    if (code == "-f" || code == "-m") {
      return pokemon.image.indexWhere(
          (element) => element.contains(code) && element.contains(color));
    }

    if (code == "-normal-" || code == "-shiny-") {
      return pokemon.image.indexWhere(
          (element) => element.contains(gender) && element.contains(code));
    }

    return imageIndex;
  }

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
                              ReusableCard(
                                blockTitle: "General",
                                cardChild: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              "- ${pokemon.species}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "- ${pokemon.height}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "- ${pokemon.weight}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const TextDivider(text: "Abilities"),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: pokemon.abilities
                                                  .map(
                                                    (i) => Text(
                                                      "- $i",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text:
                                                        "- ${pokemon.hiddenAbility}",
                                                    children: const <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            ' (hidden ability)',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const TextDivider(text: "Variant"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.blueGrey),
                                              ),
                                              onPressed: () => {
                                                (currentColor() == "normal")
                                                    ? onImageChange(
                                                        findImageIndexBasedOnString(
                                                            '-shiny-'))
                                                    : onImageChange(
                                                        findImageIndexBasedOnString(
                                                            '-normal-')),
                                              },
                                              child: (currentColor() ==
                                                      "normal")
                                                  ? const Icon(
                                                      Icons.star_border)
                                                  : const Icon(
                                                      Icons.circle_outlined),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ReusableCard(
                                blockTitle: "Breeding",
                                cardChild: Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: const [
                                            Text(
                                              ">  Grass",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              ">  Monster",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const TextDivider(text: "Cycles"),
                                        Row(
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                text: '20 ',
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        ' (4,884–5,140 steps)',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 11),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const TextDivider(text: "Gender Ratio"),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: genderButtons(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ReusableCard(
                                flex: 2,
                                blockTitle: "Games",
                                cardChild: Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index2) {
                                      return ListTile(
                                        tileColor: Colors.black,
                                        leading: Image.asset(
                                          pokemon.games[index2].getIcon(),
                                          height: 40,
                                        ),
                                        title: Text(
                                          pokemon.games[index2].name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        subtitle: Text(
                                          pokemon.games[index2].dex,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        trailing: Text(
                                          pokemon.games[index2].number,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    },
                                    itemCount: pokemon.games.length,
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(5),
                                    scrollDirection: Axis.vertical,
                                  ),
                                ),
                              ),
                              ReusableCard(
                                blockTitle: "Weakness",
                                cardChild: Expanded(
                                  child: Column(
                                    children: [
                                      const TextDivider(text: "x 1\\4"),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: pokemon.weakness.quarter
                                            .map((i) => Image.asset(
                                                  'images/types/$i.png',
                                                  height: 25,
                                                ))
                                            .toList(),
                                      ),
                                      const TextDivider(text: "x 1\\2"),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: pokemon.weakness.half
                                            .map((i) => Image.asset(
                                                  'images/types/$i.png',
                                                  height: 25,
                                                ))
                                            .toList(),
                                      ),
                                      const TextDivider(text: " x2"),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: pokemon.weakness.double
                                            .map((i) => Image.asset(
                                                  'images/types/$i.png',
                                                  height: 25,
                                                ))
                                            .toList(),
                                      ),
                                      const TextDivider(text: " x4"),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: pokemon.weakness.quadruple
                                            .map((i) => Image.asset(
                                                  'images/types/$i.png',
                                                  height: 25,
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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

  List<ElevatedButton> genderButtons() {
    if (pokemon.image.any((element) => element.contains('-g.'))) {
      return [
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
          ),
          onPressed: null,
          icon: const Icon(Icons.close),
          label: const Text('Genderless'),
        )
      ];
    }
    return [
      ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        onPressed: (hasGenderDiff()
            ? () => onImageChange(findImageIndexBasedOnString('-m'))
            : null),
        icon: const Icon(
          Icons.male,
          color: Colors.blueAccent,
        ),
        label: const Text('87.5'),
      ),
      ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        onPressed: (hasGenderDiff()
            ? () => onImageChange(findImageIndexBasedOnString('-f'))
            : null),
        icon: const Icon(
          Icons.female,
          color: Colors.redAccent,
        ),
        label: const Text('12.5'),
      )
    ];
  }
}

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 5.0),
              child: const Divider(
                color: Colors.black,
                height: 25,
              )),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 5.0, right: 10.0),
            child: const Divider(
              color: Colors.black,
              height: 25,
            ),
          ),
        ),
      ],
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {super.key,
      required this.cardChild,
      required this.blockTitle,
      this.flex = 1});

  final String blockTitle;
  final Widget cardChild;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Column(
          children: [
            TextDivider(text: blockTitle),
            cardChild,
          ],
        ),
      ),
    );
  }
}
