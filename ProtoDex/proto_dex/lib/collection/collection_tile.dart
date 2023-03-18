import 'package:flutter/material.dart';
import 'package:proto_dex/collection/collection_details_screen.dart';
import '../components/image.dart';
import '../models/item.dart';

class CollectionTile extends StatefulWidget {
  const CollectionTile(
      {super.key, required this.pokemon, this.tileColor, this.onStateChange});

  final Color? tileColor;
  final Item pokemon;
  final Function()? onStateChange;

  @override
  State<CollectionTile> createState() => _CollectionTile();
}

class _CollectionTile extends State<CollectionTile> {
  @override
  Widget build(BuildContext context) {
    return Card(child: createCard(context));
  }

  ListTile createCard(BuildContext context) {
    return ListTile(
      tileColor: widget.tileColor,
      textColor: Colors.black,
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CollectionDetailsPage(pokemon: widget.pokemon);
            },
          ),
        ),
      },
      leading: ListImage(image: "mons/" + widget.pokemon.displayImage),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.pokemon.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("#${widget.pokemon.number}")
        ],
      ),
    );
  }
}
