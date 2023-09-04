import 'dart:io';

Future<List<String>> ReadLinesFromFile(String fileName) async {
  var file = File(fileName);
  return await file.readAsLines();
}
