import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static late Directory directory;

  static loadDirectory() async =>
      directory = await getApplicationDocumentsDirectory();

  File findFile(String fileName) {
    File file = File("${directory.path}/$fileName.json");
    bool exist = file.existsSync();

    if (!exist) file.createSync();

    return file;
  }
}
