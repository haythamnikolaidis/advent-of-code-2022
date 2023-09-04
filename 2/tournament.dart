import 'dart:core';
import 'dart:io';

Future<void> main() async {
  var file = File("rpc.txt");
  var lines = await file.readAsLines();
  var part_one_score = part_one(lines);
  var part_two_score = part_two(lines);

  print('Part One Score: $part_one_score');
  print('Part Two Score: $part_two_score');
}

int part_one(List<String> lines) {
  var total_score = 0;

  for (var i = 0, len = lines.length; i < len; ++i) {
    var chars = lines[i].runes;
    int my_score = chars.last - 87;
    var their_score = chars.first - 64;

    total_score += my_score;
    if (my_score == their_score) {
      total_score += 3; //draw
    }
    if ((my_score - 1) == their_score || (their_score == 3 && my_score == 1)) {
      total_score += 6; //won
    }
  }
  return total_score;
}

int part_two(List<String> lines) {
  int total_score = 0;

  for (var i = 0, len = lines.length; i < len; ++i) {
    var chars = lines[i].runes;
    int outcome = chars.last - 87;
    int their_choice = chars.first - 64;

    if (outcome == 3) {
      var win = their_choice + 1;
      if (win > 3) win = 1;
      total_score += win + 6;
    }

    if (outcome == 2) {
      total_score += their_choice + 3;
    }

    if (outcome == 1) {
      var loose = their_choice - 1;
      if (loose < 1) loose = 3;
      print('$their_choice, $loose');
      total_score += loose;
    }
  }
  return total_score;
}

// A X - 1 1 d
// A Y - 1 2 w
// A Z - 1 3 l

// B X - 2 1 l
// B Y - 2 2 d
// B Z - 2 3 w

// C X - 3 1 w
// C Y - 3 2 l
// C Z - 3 3 d
