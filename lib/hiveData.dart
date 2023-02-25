import 'package:hive_flutter/hive_flutter.dart';
import 'main.dart';

class hiveData {
  final myBox = Hive.box("myData");

  void saveData(String cityName, String countryName) {
    myBox.put(
        (cityName  + countryName), [cityName, countryName]);
  }

  getData(String key)  {
    // var tmp = await myBox.get(key);
    return  myBox.get(key);
  }

   getKeys()  {
    var tmp =  myBox.keys;
    print("from hive");
    print(tmp);
    print("end hive");
    var gg = <String>[];
    tmp.forEach((element) {
      gg.add(element);
    });

    return gg;
  }

  void deleteAllData() {
    myBox.clear();
  }
}
