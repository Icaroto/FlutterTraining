import 'package:flutter/material.dart';
import 'package:proto_dex/screens/list.dart';
import 'start_screen.dart';
import 'package:proto_dex/file_manager.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getFiles();
  }

  void getFiles() async {
    var files = await FileManager().loadFiles();

    // print('How Many files:');
    // print(files.length);
    // print('This is pokedex:');
    // print(files['pokedex']);
    // print('This is ft:');
    // print(files['forTrade']);
    // await Future.delayed(Duration(seconds: 1));

    Navigator.pop(context);
    // Navigator.pushNamed(
    //   context,
    //   '/start_screen',
    //   arguments: ScreenArguments(
    //     'Extract Arguments Screen',
    //     'This message is extracted in the build method.',
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return StartScreen(files: files);
        },
      ),
    );
  }

//TODO: Make the ball spin
//TODO: Change background
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            'images/background/colored_ball.png',
            height: 100.0,
          ),
        ),
        const Text('Loading...')
      ],
    );
  }
}
