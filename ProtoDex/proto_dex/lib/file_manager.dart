import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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

  removeFile(String fileName) {
    File file = File("${directory.path}/$fileName.json");
    if (file.existsSync()) file.delete();
  }

  Future<List<File>>? findFiles(String? prefix, String? sufix) async {
    List<File> files = [];
    await for (var entity
        in directory.list(recursive: false, followLinks: false)) {
      File file = File(entity.path);
      if (p.extension(file.path) == ".json") {
        if (p.basename(file.path).startsWith(prefix!)) files.add(file);
      }
    }

    return files;
  }
}
