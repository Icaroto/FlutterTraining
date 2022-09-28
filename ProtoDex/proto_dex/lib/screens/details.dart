import 'package:flutter/material.dart';
import '../components/background.dart';
import '../components/basic_info.dart';
import '../components/image_container.dart';
import '../components/info_tab.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.title});

  final String title;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //TODO: Replace with typing from JSON
          //TODO: Maybe use this same page for Edit and Details
          Background(type1: '', type2: ''),
          AppBar(backgroundColor: Colors.transparent, elevation: 0.0),
          BasicInfo(),
          PokeInfoCard(),
          PokeImage(),
        ],
      ),
    );
  }
}
