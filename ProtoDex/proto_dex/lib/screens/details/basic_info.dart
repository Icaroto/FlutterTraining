import 'package:flutter/material.dart';
import 'package:proto_dex/components/image.dart';
import '../../models/pokemon.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontFamily: 'SigmarOne',
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              Text(
                pokemon.number,
                style: const TextStyle(
                  fontFamily: 'SigmarOne',
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Divider(thickness: 2, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TypeIcon(
                type: pokemon.type1,
                size: 60,
              ),
              if (pokemon.type2 != null)
                TypeIcon(
                  type: pokemon.type2,
                  size: 60,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
