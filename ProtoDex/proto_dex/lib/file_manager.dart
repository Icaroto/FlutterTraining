import 'package:flutter/services.dart';
import 'components/constants.dart';

class FileManager {
  Future<dynamic> loadFiles() async {
    Map<String, String> files;

    files = {
      kPokedexKey: await rootBundle.loadString(kPokedexFileLocation),
      kCollectionKey: await rootBundle.loadString(kCollectionFileLocation),
      kLookingForKey: await rootBundle.loadString(kLookingForFileLocation),
      kForTradeKey: await rootBundle.loadString(kForTradeFileLocation)
    };
    return files;
  }
}
