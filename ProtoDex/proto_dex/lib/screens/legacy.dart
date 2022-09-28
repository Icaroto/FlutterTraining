// import 'package:flutter/material.dart';

// class DetailsPage extends StatefulWidget {
//   const DetailsPage({super.key, required this.title});

//   final String title;

//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }

// class _DetailsPageState extends State<DetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       backgroundColor: Colors.white,
//       body: Container(
//         // decoration: const BoxDecoration(
//         //   image: DecorationImage(
//         //     image: AssetImage("images/background_11.png"),
//         //     fit: BoxFit.cover,
//         //   ),
//         // ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Column(
//               children: [
//                 Image.asset(
//                   'images/mons/charis.png',
//                   height: 300,
//                   width: 300,
//                 ),
//               ],
//             ),
//             const Divider(thickness: 2.0),
//             Column(
//               children: [
//                 const Center(child: Text('Bulbasaur')),
//                 const Center(child: Text('#001')),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 2.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(width: 1, color: Colors.white60),
//                             borderRadius:
//                                 BorderRadius.circular(100), //<-- SEE HERE
//                           ),
//                           child:
//                               Image.asset('images/types/grass.png', height: 30),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 2.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(width: 1, color: Colors.white60),
//                             borderRadius:
//                                 BorderRadius.circular(100), //<-- SEE HERE
//                           ),
//                           child: Image.asset('images/types/poison.png',
//                               height: 30),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(thickness: 2.0),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//               PokeButton(imagePath: 'images/balls/pokeball.png'),
//               PokeButton(imagePath: 'images/icons/female.png'),
//               PokeButton(imagePath: 'images/games/pla.png'),
//             ]),
//             const Divider(thickness: 2.0, color: Colors.black),
//             const Center(child: Text('Attributes')),
//             Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//               PokeAtt(imagePath: 'images/icons/alpha-icon.png'),
//               PokeAtt(imagePath: 'images/icons/shiny.png'),
//               PokeAtt(imagePath: 'images/icons/max-icon.png'),
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PokeButton extends StatelessWidget {
//   PokeButton({required this.imagePath});

//   final String imagePath;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: 50,
//       //Shadow
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black,
//               blurRadius: 0.5,
//               spreadRadius: 0.5,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         //Button
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(
//                 color: Colors.black, //color of border
//                 width: 1, //width of border
//               ),
//               color: Colors.white),
//           child: Image.asset(imagePath),
//         ),
//       ),
//     );
//   }
// }

// class PokeAtt extends StatelessWidget {
//   PokeAtt({required this.imagePath});

//   final String imagePath;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       width: 50,
//       child: Image.asset(imagePath),
//     );
//   }
// }

//How to create a pokeball with 4 parts
          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         SizedBox(
          //             height: 50,
          //             width: 50,
          //             child: Image.asset('images/background/ball_piece.png')),
          //         SizedBox(
          //             height: 50,
          //             width: 50,
          //             child: Image.asset('images/background/ball_piece_2.png')),
          //       ],
          //     ),
          //     Row(
          //       children: [
          //         SizedBox(
          //             height: 50,
          //             width: 50,
          //             child: Image.asset('images/background/ball_piece_3.png')),
          //         SizedBox(
          //             height: 50,
          //             width: 50,
          //             child: Image.asset('images/background/ball_piece_4.png')),
          //       ],
          //     ),
          //   ],
          // ),
