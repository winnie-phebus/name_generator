import 'package:collection/collection.dart' as collections;
import 'package:flutter/foundation.dart' as foundations;
import 'package:name_generator/resources/constants.dart';

class Source {
  final String display;
  final String _code;
  final String _database;

  const Source(this.display, this._code, this._database);

  String getCode() {
    return _code;
  }

  String getDatabase() {
    return _database;
  }

  static List<String> sourceConverter(List<Source> given) {
    List<String> output = [];
    for (int i = 0; i < given.length; i++) {
      output.add(given[i].display);
    }
    return output;
  }

  static Source displayToSource(String disp) {
    List<Source> ans = [];
    ans.addAll(allNameSources);
    ans.sort((a, b) {
      return a.display.compareTo(b.display);
    });
    List<String> ansStr = Source.sourceConverter(ans);
    int index = collections.binarySearch(ansStr, disp);
    if (index != -1) {
      print(ans[index].display);
      return ans[index];
    } else {
      return null;
    }
  }
}
