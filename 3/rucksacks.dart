import 'dart:core';
import '../util/open_file.dart';

Future<void> main() async {
  var lines = await ReadLinesFromFile("bags.txt");

  //print(part_one(lines));
  print(part_two(lines));
}

int part_one(List<String> lines) {
  var total_sum = 0;

  for (final line in lines) {
    var mid_point = (line.runes.length / 2).floor();
    var matched_symbols = <int>{};

    for (var i = 0; i < mid_point; ++i) {
      var c1 = line.runes.elementAt(i);

      for (var j = 0; j < mid_point; ++j) {
        var c2 = line.runes.elementAt(j + mid_point);

        if (c1 == c2) {
          matched_symbols.add(c1);
        }
      }
    }
    var sum = 0;
    for (final symbol in matched_symbols) {
      sum += getPriorityScoreForCodePoint(symbol);
    }
    total_sum += sum;
  }
  return total_sum;
}

int getPriorityScoreForCodePoint(int code_point) {
  if (code_point < 97) {
    //uppercase
    return code_point - 38;
  }
  return code_point - 96;
}

int part_two(List<String> lines) {
  var total_sum = 0;
  for (var i = 0; i < lines.length; i += 3) {
    var elves = lines.getRange(i, i + 3);
    var common_symbols = <int>{};
    for (final c1 in elves.first.runes) {
      for (final c2 in elves.last.runes) {
        if (c1 == c2) {
          common_symbols.add(c1);
        }
      }
    }
    var shared_badges = <int>{};
    for (final c3 in elves.elementAt(1).runes) {
      if (common_symbols.contains(c3)) {
        shared_badges.add(c3);
      }
    }
    for (final badge in shared_badges) {
      total_sum += getPriorityScoreForCodePoint(badge);
    }
  }
  return total_sum;
}
