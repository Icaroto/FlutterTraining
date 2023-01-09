import 'package:flutter/material.dart';

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

const TextStyle loadingTextStyle = TextStyle(fontSize: 30, color: Colors.amber);

BoxDecoration containerBoxDecoration = BoxDecoration(
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
);

const TextStyle buttonTextStyle = TextStyle(fontSize: 20, color: Colors.white);
