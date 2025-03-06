import 'dart:convert';
import 'dart:io';

void main() {
  // ./IconPark/source/icons.json

  final iconsJsonFile = File('./IconPark/source/icons.json');
  final iconsJson = iconsJsonFile.readAsStringSync();
  var icons = JsonDecoder().convert(iconsJson);
  if (icons is! List) {
    print('icons.json is not a array');
    return;
  }

  final blockName = {'return', 'switch'};

  // icons = icons.sublist(0, 200);
  final Set<String> nameSet = {};

  final codes = icons.map((v) {
    String name = toCamelCase(v['name']);
    if (blockName.contains(name)) {
      name = '${name}_';
    }

    if (nameSet.contains(name)) {
      print('nameSet.contains(name) $name');
      return '';
    }
    nameSet.add(name);

    String svg = v['svg'];
    // 正则替换参数

    svg = svg.replaceAllMapped(RegExp(r'stroke-linejoin="(\w+)"'), (match) {
      return 'stroke-linejoin="\${props.strokeLineJoin?.name ?? "${match.group(1)}"}"';
    });
    svg = svg.replaceAllMapped(RegExp(r'stroke-linecap="(\w+)"'), (match) {
      return 'stroke-linecap="\${props.strokeLineCap?.name ?? "${match.group(1)}"}"';
    });
    svg = svg.replaceAllMapped(RegExp(r'stroke-width="(\d+)"'), (match) {
      return 'stroke-width="\${props.strokeWidth ?? "${match.group(1)}"}"';
    });

    svg = svg.replaceAllMapped(RegExp(r'(fill|stroke)="([^"]+)"'), (match) {
      final type = match.group(1);
      final color = match.group(2)?.toLowerCase();
      int? index;
      if (color == 'black' || color == '#000' || color == '#000000') {
        index = 0;
      } else if (color == '#2f88ff') {
        index = 1;
      } else if (color == 'white' || color == '#fff' || color == '#ffffff') {
        index = 2;
      } else if (color == '#43ccf8') {
        index = 3;
      }
      if (index != null) {
        return '$type="\${props.colors.elementAtOrNull($index) ?? "$color"}"';
      }
      return match.group(0) ?? '';
    });

    svg = svg.replaceAll('\n', '');

    return '''
/// ${v['name']} ${v['title']}
/// category: ${v['category']} ${v['categoryCN']}
/// author: ${v['author']}
/// tag: ${v['tag'].join(', ')}
/// rtl: ${v['rtl']}
static IconParkData $name = IconParkData("$name", ${v['rtl']?.toString() ?? 'false'}, (props) => '$svg');
''';
  });

  final code = '''
import './icon_park_base.dart';

class IconPark {
${codes.join('\n')}
}

final List<IconParkData> allIcons = [${nameSet.map((name) {
    return "IconPark.$name";
  }).join(', ')}];

''';

  final codeFile = File('./lib/icons.dart');
  if (codeFile.existsSync()) {
    codeFile.deleteSync();
  }
  codeFile.writeAsStringSync(code);
}

// 减号分割转小驼峰
String toCamelCase(String str) {
  final parts = str.split('-');
  return parts[0] +
      parts
          .sublist(1)
          .map((v) {
            return v[0].toUpperCase() + v.substring(1);
          })
          .join('');
}
