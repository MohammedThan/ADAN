import 'adanAPI.dart';
import 'package:http/http.dart' as http;

class API {
  Future<Adan> getAdan(String city, String country, DateTime date) async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://api.aladhan.com/v1/timingsByCity/${date.day}-${date.month}-${date.year}?city=$city&country=$country&method=4");
    var response = await client.get(uri);
    var jsonString = response.body;
    if (jsonString == null) {
      throw Exception("Error");
    }
    return adanFromJson(jsonString);
  }
}

  // List <Adan>? adan;
  // bool isLoaded=false;

  // Future<void> getAdan() async{
  //   try{
  //     var response = await http.get("https://api.aladhan.com/v1/calendarByCity?city=Kuala%20Lumpur&country=Malaysia&method=8&month=10&year=2021");
  //     var data = response.data;
  //     var rest = data["data"] as List;
  //     adan = rest.map<Adan>((json) => Adan.fromJson(json)).toList();
  //     isLoaded=true;
  //   }catch(e){
  //     print(e);
  //   }
  // }

