import "dart:io";

Future<void> main() async {
  var file = File("input.txt");
  var lines = await file.readAsLines();

  var currentTotal = 0;
  var totalCalories = 0;
  var topThreeTotals = [0, 0, 0];

  for (var i = 0, len = lines.length; i < len; ++i) {
    if (lines[i] != "") {
      currentTotal += int.parse(lines[i]);
    } else {
        for (var i = 0, len = topThreeTotals.length; i < len; ++i) {
          if (topThreeTotals[i] < currentTotal)
          {
            topThreeTotals.insert(i, currentTotal);
            topThreeTotals.removeLast();
            break;
          }
        }
      currentTotal = 0;
    }
  }

  print(topThreeTotals.length);
  
  for (var i = 0, len = topThreeTotals.length; i < len; ++i) {
      print(topThreeTotals[i]);
      totalCalories += topThreeTotals[i];
  }

  print('The top three elves have $totalCalories calories');

  return;
}
