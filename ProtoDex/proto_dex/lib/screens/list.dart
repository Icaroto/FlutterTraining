import 'package:flutter/material.dart';
import '../screens/details.dart';
import '../components/pokemon.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../components/pokemon.dart';

class ListPage extends StatefulWidget {
  ListPage(this.listBase);

  String listBase;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Pokemon> pokemons = [];

  // void loadSamples() async {
  //   //Single Record
  //   //final String rawJson = await rootBundle.loadString('data/sample.json');
  //   //Map<String, dynamic> map = jsonDecode(rawJson);
  //   //Pokemon pokemon = Pokemon.fromJson(map);
  //   final String rawJson = await rootBundle.loadString('data/samples.json');
  //   Iterable l = jsonDecode(rawJson);

  //   pokemons = List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));

  //   print(pokemons.length);

  //   // pokemons.forEach((pokemon) {
  //   //   print(pokemon.name);
  //   //   print(pokemon.type1);
  //   //   print(pokemon.type2);
  //   //   print(pokemon.image);
  //   // });
  // }
  void loadList() async {
    Iterable l = jsonDecode(widget.listBase);
    pokemons = List<Pokemon>.from(l.map((model) => Pokemon.fromJson(model)));

    print('Number of pokemons in list');
    print(pokemons.length);

    pokemons.forEach((pokemon) {
      print(pokemon.name);
      print(pokemon.type1);
      print(pokemon.type2);
      print(pokemon.image);
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Choose your destiny!'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () {
                  loadList();
                },
                child: Text('TEST!')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DetailsPage(pokemon: pokemons.first);
                    }),
                  );
                },
                child: Text('BUBS!')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DetailsPage(pokemon: pokemons[1]);
                    }),
                  );
                },
                child: Text('CHARM!')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DetailsPage(pokemon: pokemons[2]);
                    }),
                  );
                },
                child: Text('CHARIS!')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return DetailsPage(pokemon: pokemons.first);
            }),
          );
        },
        // onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
