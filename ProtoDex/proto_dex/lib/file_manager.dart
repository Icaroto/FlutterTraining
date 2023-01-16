import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileManager {
  static late Directory directory;

  static loadDirectory() async =>
      directory = await getApplicationDocumentsDirectory();

  // static createDirectory() =>
  //     Directory("collections").create().then((Directory directory) {
  //       print(directory.path);
  //     });

  File findFile(String fileName) {
    File file = File("${directory.path}/$fileName.json");
    bool exist = file.existsSync();

    if (!exist) file.createSync();

    return file;
  }

  Future<List<File>>? findFiles(String? prefix, String? sufix) async {
    List<File> files = [];
    await for (var entity
        in directory.list(recursive: true, followLinks: false)) {
      File file = File(entity.path);
      if (p.extension(file.path) == ".json") {
        // print("Found in:${entity.path}");
        if (p.basename(file.path).startsWith(prefix!)) files.add(file);
      }
    }

    return files;
  }
}
