import 'package:collection/collection.dart' as collections;
import 'package:flutter/foundation.dart' as foundations;
import 'package:name_generator/resources/constants.dart';

class Origin {
  final String display;
  final String _code;
  final String _database;

  const Origin(this.display, this._code, this._database);

  String getCode() {
    return _code;
  }

  String getDatabase() {
    return _database;
  }

  static List<String> sourceConverter(List<Origin> given) {
    List<String> output = [];
    for (int i = 0; i < given.length; i++) {
      output.add(given[i].display);
    }
    return output;
  }

  static Origin displayToSource(String disp) {
    List<Origin> ans = [];
    ans.addAll(allNameSources);
    ans.sort((a, b) {
      return a.display.compareTo(b.display);
    });
    List<String> ansStr = Origin.sourceConverter(ans);
    int index = collections.binarySearch(ansStr, disp);
    if (index != -1) {
      print(ans[index].display);
      return ans[index];
    } else {
      return null;
    }
  }
}
