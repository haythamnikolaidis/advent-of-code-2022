import '../util/open_file.dart';

Future<int> main() async {
  final lines = await ReadLinesFromFile('cargo_1.txt');
  print(part_one(lines));
  return 0;
}

String part_one(List<String> lines) {
  final data = GetStacksAndInstructions(lines);
  return '${data.$1.length}, ${data.$2.length}';
}

(List<String>, List<String>) GetStacksAndInstructions(List<String> lines) {
  var seperator = 0;
  for (var i = 0, len = lines.length; i < len; ++i) {
    if (lines[i] == "") {
      seperator = i;
    }
  }
  return (
    lines.sublist(0, seperator),
    lines.sublist(seperator + 1, lines.length)
  );
}
