import 'dart:io';
import '../util/open_file.dart';

Future<int> main() async {
  final lines = await ReadLinesFromFile('sections.txt');
  print(part_two(lines));
  return 0;
}

int part_one(List<String> lines) {
  var count = 0;
  for (final line in lines) {
    final sections_ids = split_sections(line);
    final sections =
        (parse_section(sections_ids.first), parse_section(sections_ids.second));
    if (sections.$1.lhs <= sections.$2.lhs &&
        sections.$1.rhs >= sections.$2.rhs) {
      ++count;
    } else if (sections.$1.lhs >= sections.$2.lhs &&
        sections.$1.rhs <= sections.$2.rhs) {
      ++count;
    }
  }
  return count;
}

int part_two(List<String> lines) {
  var count = 0;
  for (final line in lines) {
    final sections_ids = split_sections(line);
    final sections =
        (parse_section(sections_ids.first), parse_section(sections_ids.second));

    if (sections.$1.lhs <= sections.$2.lhs &&
        sections.$1.rhs >= sections.$2.rhs) {
      ++count;
    } else if (sections.$1.lhs >= sections.$2.lhs &&
        sections.$1.rhs <= sections.$2.rhs) {
      ++count;
    } else if (sections.$1.lhs <= sections.$2.rhs &&
        sections.$1.lhs >= sections.$2.lhs) {
      ++count;
    } else if (sections.$1.rhs >= sections.$2.lhs &&
        sections.$1.rhs <= sections.$2.rhs) {
      ++count;
    }
  }
  return count;
}

({int lhs, int rhs}) parse_section(String section) {
  var split = section.split('-');

  return (lhs: int.parse(split[0]), rhs: int.parse(split[1]));
}

({String first, String second}) split_sections(String line) {
  var sections = line.split(',');
  return (first: sections[0].trim(), second: sections[1].trim());
}
