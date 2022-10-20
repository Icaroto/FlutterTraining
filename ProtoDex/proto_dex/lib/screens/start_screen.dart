import 'package:flutter/material.dart';
import '../screens/base_list.dart';
import '../components/pokemon.dart';
import '../components/constants.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.files, required this.pokedex});

  final Map<String, String> files;
  final List<Pokemon> pokedex;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          kBasicBackground,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  MainScreenButton(
                    buttonName: '(Soon)',
                    imagePath: 'images/background/ball_piece.png',
                    pokemons: widget.pokedex,
                  ),
                  MainScreenButton(
                    buttonName: '(Soon)',
                    imagePath: 'images/background/ball_piece_2.png',
                    pokemons: widget.pokedex,
                  ),
                ],
              ),
              Row(
                children: [
                  MainScreenButton(
                    buttonName: 'Pokedex',
                    imagePath: 'images/background/colored_ball.png',
                    pokemons: widget.pokedex,
                  ),
                ],
              ),
              Row(
                children: [
                  MainScreenButton(
                    buttonName: '(Soon)',
                    imagePath: 'images/background/ball_piece_3.png',
                    pokemons: widget.pokedex,
                  ),
                  MainScreenButton(
                    buttonName: '(Soon)',
                    imagePath: 'images/background/ball_piece_4.png',
                    pokemons: widget.pokedex,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainScreenButton extends StatelessWidget {
  const MainScreenButton(
      {super.key,
      required this.buttonName,
      required this.imagePath,
      required this.pokemons});

  final String buttonName;
  final String imagePath;
  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1D1E33),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ListScreen(pokemons: pokemons);
                },
              ),
            );
          },
          child: Column(
            children: [
              Image.asset(
                imagePath,
                height: 100,
              ),
              Text(
                buttonName,
                style: const TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
