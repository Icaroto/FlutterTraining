import 'dart:convert';
import 'dart:io';
import 'package:proto_dex/file_manager.dart';

class Preferences {
  bool revealUncaught;

  Preferences({required this.revealUncaught});

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      revealUncaught: json['revealUncaught'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'revealUncaught': revealUncaught,
    };
  }

  save() {
    File preferencesLocalFile = FileManager().findFile('preferences');
    preferencesLocalFile.writeAsStringSync(jsonEncode(this));
  }
}
