import 'package:flutter/material.dart';
import 'package:proto_dex/components/switch_option.dart';
import 'package:proto_dex/constants.dart';
import 'package:proto_dex/models/preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  Preferences prefs = kPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Preferences"),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(children: [
                SwitchOption(
                  title: "Hide Uncaught",
                  switchValue: kPreferences.revealUncaught,
                  onSwitch: (bool value) async {
                    kPreferences.revealUncaught = value;
                    kPreferences.save();
                    setState(() {});
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
    // return Drawer(
    //   child: ListView(
    //     padding: EdgeInsets.zero,
    //     children: [
    //       const SizedBox(
    //         height: 80,
    //         child: DrawerHeader(
    //           decoration: BoxDecoration(color: Colors.blue),
    //           child: Text('Filters'),
    //         ),
    //       ),
    //       Column(
    //         children: [],
    //       ),
    //       const Divider(thickness: 2),
    //       Center(
    //         child: TextButton(
    //           onPressed: this..pop(context),
    //           child: const Text("Close"),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
