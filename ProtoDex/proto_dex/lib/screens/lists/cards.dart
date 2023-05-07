import 'package:flutter/material.dart';
import 'package:proto_dex/models/pokemon.dart';
import 'package:proto_dex/screens/lists/tile.dart';
import '../../components/image.dart';
import '../../models/enums.dart';
import '../../models/item.dart';

Widget singleCard(context, index, pokemons, Function()? onStateChange,
    {color = Colors.black26}) {
  return PokemonTile(
    tileColor: color,
    pokemon: pokemons[index],
    onStateChange: onStateChange,
  );
}

Widget multipleCards(context, index, pokemons, Function()? onStateChange,
    {subLevel = false}) {
  final GlobalKey expansionTileKey = GlobalKey();

  void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 240)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  var image = "";
  bool shadow = false;
  if (pokemons is List<Item>) {
    image = "mons/${pokemons[index].displayImage}";
    shadow = Item.isCaptured(pokemons[index]) != CaptureType.full;
  } else {
    image = "mons/${pokemons[index].image[0]}";
  }
  return Card(
    child: ExpansionTile(
      key: expansionTileKey,
      onExpansionChanged: (value) {
        if (value) {
          scrollToSelectedContent(expansionTileKey: expansionTileKey);
        }
      },
      collapsedBackgroundColor: (subLevel) ? null : Colors.black26,
      backgroundColor: (subLevel) ? Colors.black12 : Colors.black26,
      leading: ListImage(
        image: image,
        shadowOnly: shadow,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pokemons[index].name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("#${pokemons[index].number}")
        ],
      ),
      trailing: (pokemons is List<Pokemon>)
          ? Text('+${pokemons[index].forms.length - 1}')
          : Text('         +${pokemons[index].forms.length - 1}'),
      subtitle: (pokemons is List<Pokemon>)
          ? Text(pokemons[index].formattedTypes())
          : null,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index2) {
            return (pokemons[index].forms[index2].forms.isEmpty)
                ? singleCard(
                    context, index2, pokemons[index].forms, onStateChange,
                    color: null)
                : multipleCards(
                    context, index2, pokemons[index].forms, onStateChange,
                    subLevel: true);
          },
          itemCount: pokemons[index].forms.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
        )
      ],
    ),
  );
}

// Widget collectionCard(context, Group group, Function() onStateChange,
//     {subLevel = false}) {
//   final GlobalKey expansionTileKey = GlobalKey();

//   void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
//     final keyContext = expansionTileKey.currentContext;
//     if (keyContext != null) {
//       Future.delayed(const Duration(milliseconds: 240)).then((value) {
//         Scrollable.ensureVisible(keyContext,
//             duration: const Duration(milliseconds: 200));
//       });
//     }
//   }

//   // if (style == "Plain") {
//   //   return CollectionTile(
//   //     pokemon: pokemons[index],
//   //     onStateChange: onStateChange,
//   //   );
//   // }

//   // var image = pokemons[index].displayImage;
//   return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//     clipBehavior: Clip.antiAlias,
//     child: ExpansionTile(
//       key: expansionTileKey,
//       onExpansionChanged: (value) {
//         if (value) {
//           scrollToSelectedContent(expansionTileKey: expansionTileKey);
//         }
//       },
//       collapsedBackgroundColor:
//           (group.color == null) ? Colors.black26 : group.color,
//       backgroundColor: (group.color == null) ? Colors.black26 : group.color,

//       // collapsedBackgroundColor: (subLevel) ? null : Colors.black26,
//       // backgroundColor: (subLevel) ? Colors.black12 : Colors.black26,
//       leading: ListImage(
//         image: group.image,
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             group.name,
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           // Text("#${pokemons[index].number}")
//         ],
//       ),
//       trailing: Text('+${group.items.length}'),
//       // subtitle: Text(pokemons[index].formattedTypes()),
//       children: [
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index2) {
//             return CollectionTile(
//               pokemon: group.items[index2],
//               onStateChange: onStateChange,
//             );
//           },
//           itemCount: group.items.length,
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(5),
//           scrollDirection: Axis.vertical,
//         )
//       ],
//     ),
//   );
// }
