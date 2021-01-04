import 'package:name_generator/services/networking.dart';

const btnApiKey = 'wi948351677';
const JSONbtnUrl = 'https://www.behindthename.com/api/random.json';

class NameRetriever {
  Future<dynamic> getRandomNames(
      String gender, String usage, int number, bool surname) async {
    String surnameString = surname ? 'yes' : 'no';
    String url = JSONbtnUrl +
        '?usage=$usage&gender=$gender&number=$number&key=$btnApiKey';
    NetworkHelper networkHelper = NetworkHelper(url);

    print('returning from NameRetriever');
    return await networkHelper.getData();
  }

  Future<dynamic> getLastName(String usage) async {
    return await getRandomNames('', usage, 1, true);
  }

  List<String> nameDataToString(dynamic nameData, int length) {
    var generatedNames = new List(length);
    for (int i = 0; i < length; i++) {
      generatedNames[i] = nameData['names'][i];
    }
    return generatedNames;
  }
}
