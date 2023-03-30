import 'package:flutter/material.dart';
import '../../components/basic.dart';
import '../../components/image.dart';
import '../../models/game.dart';
import '../../models/pokemon.dart';

class GamesInformationCard extends StatelessWidget {
  const GamesInformationCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DetailsCard(
      flex: 2,
      blockTitle: "Games",
      cardChild: Expanded(
        child: ListView.builder(
          itemBuilder: (context, index2) {
            return ListTile(
              // tileColor: Colors.black,
              leading: ListImage(
                image: Game.gameIcon(pokemon.games[index2]),
              ),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  pokemon.games[index2].name,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              subtitle: Text(
                pokemon.games[index2].dex,
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
              trailing: Text(
                '#${pokemon.games[index2].number}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          itemCount: pokemon.games.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
