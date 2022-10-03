import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:proto_dex/components/constants.dart';
import 'package:proto_dex/screens/list.dart';

class StartScreen extends StatefulWidget {
  StartScreen({this.files});

  final files;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('images/background/ball_3.png'),
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1),
                  BlendMode.modulate,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    MainScreenButton(
                      buttonName: 'Pokedex!',
                      imagePath: 'images/background/ball_piece.png',
                      routeName: 'pokedex',
                      file: widget.files[kPokedexKey],
                    ),
                    MainScreenButton(
                      buttonName: 'Tracker',
                      imagePath: 'images/background/ball_piece_2.png',
                      routeName: 'tracker',
                      file: widget.files[kCollectionKey],
                    ),
                  ],
                ),
                Row(
                  children: [
                    MainScreenButton(
                      buttonName: 'LF',
                      imagePath: 'images/background/ball_piece_3.png',
                      routeName: 'looking_for',
                      file: widget.files[kLookingForKey],
                    ),
                    MainScreenButton(
                      buttonName: 'FT',
                      imagePath: 'images/background/ball_piece_4.png',
                      routeName: 'for_trade',
                      file: widget.files[kForTradeKey],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreenButton extends StatelessWidget {
  MainScreenButton(
      {required this.buttonName,
      required this.imagePath,
      required this.routeName,
      required this.file});

  final String buttonName;
  final String imagePath;
  final String routeName;
  final String file;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF1D1E33),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Scaffold(body: ListPage(file));
                },
              ),
            );
          },
          child: Column(
            children: [
              Image.asset(imagePath),
              Text(
                buttonName,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
