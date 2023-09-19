import '../util/open_file.dart';
import '../util/stackonator.dart';

Future<int> main() async {
  final lines = await ReadLinesFromFile('cargo.txt');
  print(part_two(lines));
  return 0;
}

String part_one(List<String> lines) {
  final data = GetStacksAndInstructions(lines);

  final stack_data = data.$1;
  final stacks = populate_stacks(stack_data);

  final instructions = parse_instructions(data.$2);

  for (final inst in instructions) {
    var cs = stacks[inst.from].popMany(amount: inst.amount);
    stacks[inst.to].pushMany(cs);
  }

  var result = '';

  stacks.forEach((element) => result += element.peak);

  return result;
}

String part_two(List<String> lines) {
  final data = GetStacksAndInstructions(lines);

  final stack_data = data.$1;
  final stacks = populate_stacks(stack_data);

  final instructions = parse_instructions(data.$2);

  for (final inst in instructions) {
    var cs = stacks[inst.from].popManyInOrder(amount: inst.amount);
    stacks[inst.to].pushMany(cs);
  }

  var result = '';

  stacks.forEach((element) => result += element.peak);

  return result;
}

List<Stack<String>> populate_stacks(List<String> stack_data) {
  final stack_count = int.parse(stack_data.removeLast().trim().split(' ').last);
  var stacks = <Stack<String>>[];

  for (var i = 0; i < stack_count; ++i) {
    stacks.add(new Stack<String>());
  }

  stack_data.reversed.forEach((element) {
    var index = 0;
    for (var i = 0, len = element.runes.length; i < len; ++i) {
      if (element.runes.elementAt(i) == '['.codeUnitAt(0)) {
        //start of itesm
        final stack_index = i ~/ (element.length / stack_count);
        stacks[stack_index].push(element.substring(i + 1, i + 2));
      }
    }
  });

  return stacks;
}

List<Instruction> parse_instructions(List<String> instructions_data) {
  return List.generate(
      instructions_data.length, (i) => new Instruction(instructions_data[i]));
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

class Instruction {
  int amount = 0;
  int from = 0;
  int to = 0;

  Instruction(String instructions_datum) {
    var parts = instructions_datum.split(' ');
    if (parts[0] != 'move') {
      this.amount = 0;
      this.from = 0;
      this.to = 0;
    }

    this.amount = int.parse(parts[1]);
    this.from = int.parse(parts[3]) - 1;
    this.to = int.parse(parts[5]) - 1;
  }

  String toString() => 'move $amount from $from to $to';
}
