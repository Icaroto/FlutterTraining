import 'package:flutter/material.dart';

const String kPokedexFileLocation = 'data/pokedex.json';
const String kPokedexKey = 'pokedex';

const String kCollectionFileLocation = 'data/collection.json';
const String kCollectionKey = 'collection';

const String kLookingForFileLocation = 'data/lf.json';
const String kLookingForKey = 'lookingFor';

const String kForTradeFileLocation = 'data/ft.json';
const String kForTradeKey = 'forTrade';

Column kLoadingBackground = Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Center(
      child: Image.asset('images/background/colored_ball.png'),
    ),
    const Text(
      'Loading...',
      style: TextStyle(
        fontSize: 30,
        color: Colors.amber,
      ),
    )
  ],
);

Container kBasicBackground = Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: const AssetImage('images/background/ball_3.png'),
      colorFilter: ColorFilter.mode(
        Colors.white.withOpacity(0.1),
        BlendMode.modulate,
      ),
    ),
  ),
);
