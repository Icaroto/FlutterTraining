import 'package:flutter/material.dart';
import 'package:proto_dex/fortrade/fortrade_details_screen.dart';
import '../components/image.dart';
import '../models/item.dart';

class ForTradeTile extends StatefulWidget {
  const ForTradeTile(
      {super.key,
      required this.pokemons,
      required this.indexes,
      this.tileColor,
      this.onStateChange,
      this.onDelete});

  final Color? tileColor;
  final List<Item> pokemons;
  final List<int> indexes;
  final Function()? onStateChange;
  final Function(Item)? onDelete;

  @override
  State<ForTradeTile> createState() => _ForTradeTile();
}

class _ForTradeTile extends State<ForTradeTile> {
  @override
  Widget build(BuildContext context) {
    Item pokemon = widget.pokemons.current(widget.indexes);

    return Card(
        child: ListTile(
      tileColor: widget.tileColor,
      textColor: Colors.black,
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ForTradeDetailsPage(
                pokemons: widget.pokemons,
                indexes: widget.indexes,
                onStateChange: widget.onStateChange,
              );
            },
          ),
        ),
      },
      onLongPress: () {
        widget.onDelete!(pokemon);
      },
      leading: ListImage(image: "mons/${pokemon.displayImage}"),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pokemon.displayName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("#${pokemon.number}")
        ],
      ),
    ));
  }
}
