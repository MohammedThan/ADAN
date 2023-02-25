import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:location/location.dart';
import 'adanAPI.dart';
import 'countryPage.dart';
import 'hiveData.dart';
import 'api.dart';
// import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geoc;
import 'Notifications.dart';


class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
 
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<String>> GetAddressFromLatLong() async {
    try {
      var cor = await _getGeoLocationPosition();
      List<geoc.Placemark> placemarks =
          await geoc.placemarkFromCoordinates(cor.latitude, cor.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        geoc.Placemark place = placemarks[0];
        return <String>[place.locality.toString(), place.country.toString()];
      } else {
        return <String>[];
      }
    } catch (e) {
      rethrow;
    }
  }

  String city = "your city";
  String country = "your country";
  bool firsttime = true;
  DateTime theDate = DateTime.now();
  int currentIndex = 0;
  final sceen=[
    homePage(),
    countryPage(),
  ];

  void refresh(String newCity, String newCountry) {
    setState(() {
      city = newCity;
      country = newCountry;
    });
  }

  void refreshDate(DateTime newDate) {
    setState(() {
      theDate = newDate;
    });
  }


  bool isNextSalah(Adan snapShopt, String salah) {
    DateTime now = DateTime.now();

    if (now.isBefore(convDate(snapShopt.data.timings.fajr))) {
      return "Fajr" == salah;
    } else if (now.isAfter(convDate(snapShopt.data.timings.fajr)) &&
        now.isBefore(convDate(snapShopt.data.timings.dhuhr))) {
      return "Dhuhr" == salah;
    } else if (now.isAfter(convDate(snapShopt.data.timings.dhuhr)) &&
        now.isBefore(convDate(snapShopt.data.timings.asr))) {
      return "Asr" == salah;
    } else if (now.isAfter(convDate(snapShopt.data.timings.asr)) &&
        now.isBefore(convDate(snapShopt.data.timings.maghrib))) {
      return "Maghrib" == salah;
    } else if (now.isAfter(convDate(snapShopt.data.timings.maghrib)) &&
        now.isBefore(convDate(snapShopt.data.timings.isha))) {
      return "Isha" == salah;
    }

    return false;
  }

  DateTime convDate(String toConv) {
    DateTime now = DateTime.now();
    DateTime dateTime =
        DateFormat("yyyy-MM-dd HH:mm").parse("2023-01-01 $toConv");
    DateTime dateTimeWithDate =
        DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute);
    return dateTimeWithDate;
  }  


  Widget build(BuildContext context) {
    hiveData hive = new hiveData();
    API api = new API();
    return FutureBuilder(
        future: GetAddressFromLatLong(),
        builder: (context, snapshot) {
          print("in the bulider");
          if (snapshot.connectionState == ConnectionState.waiting &&
              firsttime) {
            return Center(child: const CircularProgressIndicator());
          } else if (snapshot.hasError && firsttime) {
            return Text("Error: ${snapshot.error}");
          } else {
            if (firsttime) {
            print("in the first time");
            city = snapshot.data
                .toString()
                .substring(1, snapshot.data.toString().indexOf(','));
            country = snapshot.data.toString().substring(
                snapshot.data.toString().indexOf(',') + 1,
                snapshot.data.toString().length - 1);
            }
            firsttime = false;


            print("the city $city");
            print("the country $country");

            return FutureBuilder(
                future: api.getAdan(city, country, theDate),
                builder: (context, snapshot) {
                  print("in the bulider");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    print(snapshot.data!.data.timings.asr);
                    return (Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            
                            centerTitle: true,
                            leading: IconButton(
                              icon: const Icon(Icons.date_range),
                              color: Colors.black,
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                    context: context,
                                    initialDate: theDate,
                                    firstDate: DateTime(2000),
                                    lastDate:
                                        DateTime(DateTime.now().year + 5));
                                if (newDate != null) {
                                  theDate = newDate;
                                }
                                if (newDate != null) {
                                  // && newDate != theDate) {
                                  refreshDate(newDate);
                                  print("the date is $theDate");
                                }
                              },
                            ),
                            actions: [
                              PopupMenuButton(
                                
                                child: (TextButton.icon(
                                  label: Text(
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                    {
                                      if (city != "your city")
                                        city
                                      else
                                        snapshot.data.toString().substring(
                                            1,
                                            snapshot.data
                                                .toString()
                                                .indexOf(","))
                                    }
                                        .toString()
                                        .replaceAll("}", "")
                                        .replaceAll("{", ""),
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                  ),
                                  onPressed: null,
                                )),
                                itemBuilder: (context) {
                                  if (city == "your city")
                                    city = snapshot.data.toString().substring(1,
                                        snapshot.data.toString().indexOf(","));

                                  hive.saveData(city, country);
                                  print("\n the shit:");
                                  var keys = hive.getKeys();
                              
                                  return [
                                    for (var i = 0; i < keys.length; i++)
                                      PopupMenuItem(
                                          onTap: () {
                                            refresh(hive.getData(keys[i])[0],
                                                hive.getData(keys[i])[1]);
                                          },
                                          value: hive.getData(keys[i][0]),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${hive.getData(keys[i])[0]}',
                                              ),
                                              Row(
                                                children: [
                                                  
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                      '${hive.getData(keys[i])[1]}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ))
                                  ];
                                },
                                
                              )
                            ]),
                        body: Column(
                          children: [
                            // Text(snapshot.data.toString()),
                            // myCard(),
                            Center(
                                child: Image.asset("assets/blue.png",
                                    width: 300.0, height: 300.0)),
                            Text(
                                " ${snapshot.data?.data.date.hijri.weekday.en} ${snapshot.data?.data.date.hijri.day} ${snapshot.data?.data.date.hijri.month.en}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                )),

                            adanCard(
                                "Fajr",
                                snapshot.data!.data.timings.fajr,
                                Icon(Icons.wb_sunny_outlined),
                                isNextSalah(snapshot.data!, "Fajr")),
                            adanCard(
                                "Dhuhr",
                                snapshot.data!.data.timings.dhuhr,
                                Icon(Icons.sunny),
                                isNextSalah(snapshot.data!, "Dhuhr")),
                            adanCard(
                                "Asr",
                                snapshot.data!.data.timings.asr,
                                Icon(Icons.sunny_snowing),
                                isNextSalah(snapshot.data!, "Asr")),
                            adanCard(
                                "Maghrib",
                                snapshot.data!.data.timings.maghrib,
                                Icon(Icons.nightlight_round),
                                isNextSalah(snapshot.data!, "Maghrib")),
                            adanCard(
                                "Isha",
                                snapshot.data!.data.timings.isha,
                                Icon(Icons.nights_stay),
                                isNextSalah(snapshot.data!, "Isha")),
                           
  

                          ],
                        ),
                      
                      )
                    
                    );
                  }
                });
          }
        });
  }

  Widget myCard() {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 20,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(

            children: <Widget>[
              Text("Fajer"),
              Text("45"),
              Text("20;20"),
            ]),
      ),
    );
  }

  Widget adanCard(String salah, String time, Icon icon, bool isNextSalah) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
     
      SizedBox(
        height: 12,
      ),
      Container(
        margin: const EdgeInsets.only(top: 0, left: 10, right: 20, bottom: 0),
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 20,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: isNextSalah ? Colors.blue : Colors.white,
          border: Border.all(
            color: Color.fromARGB(255, 21, 151, 211),
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            icon,
           
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  salah,
                ),
                
                
              ],
            ),
            Spacer(),
            Text(
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                isNextSalah
                    ? new DateTime.now()
                            .difference(convDate(time))
                            .inHours
                            .toString() +
                        ":" +
                        (new DateTime.now()
                                        .difference(convDate(time))
                                        .inMinutes %
                                    60 ==
                                0
                            ? "0" +
                                new DateTime.now()
                                    .difference(convDate(time))
                                    .inMinutes
                                    .toString()
                            : (new DateTime.now()
                                        .difference(convDate(time))
                                        .inMinutes %
                                    60)
                                .toString())
                    : ""),
            Spacer(),
            Text(
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
              time,
            ),
          ],
        ),
      )
    ]);
  }
}

