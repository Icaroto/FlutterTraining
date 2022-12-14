import 'package:flutter/material.dart';
import 'package:proto_dex/components/image.dart';
import 'package:proto_dex/models/enums.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo(
      {Key? key,
      required this.name,
      required this.number,
      required this.type1,
      required this.type2})
      : super(key: key);

  // final Pokemon pokemon;
  final String name;
  final String number;
  final PokemonType type1;
  final PokemonType? type2;

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
                name,
                style: const TextStyle(
                  fontFamily: 'SigmarOne',
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              Text(
                number,
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
                type: type1,
                size: 60,
              ),
              if (type2 != null)
                TypeIcon(
                  type: type2,
                  size: 60,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
