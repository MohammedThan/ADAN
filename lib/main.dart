import 'package:adan/Thikr.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:location/location.dart';
import 'Notifications.dart';
import 'adanAPI.dart';
import 'countryPage.dart';
import 'hiveData.dart';
import 'api.dart';
// import 'package:geocoding/geocoding.dart' as geo;

import 'homePage.dart';

void main() async {
  await Hive.initFlutter();
  // List<Placemark> placemarks =
  //     await placemarkFromCoordinates(52.2165157, 6.9437819);
  // print(placemarks);
  var box = await Hive.openBox('myData');
  API api = new API();
  var adan = await api.getAdan("al qatif", "saudi arabia", new DateTime.now());
  print(adan.data.timings.fajr);

  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: homePage(),
  // ));
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void initState() {
    super.initState();

    // NotificationApi.init();
  }


  int index = 0;
  homePage x = new homePage();
  final Screen = [homePage(), ThikerPage(),countryPage()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Screen[index],
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (GNav(
                  rippleColor:
                      Colors.grey, // tab button ripple color when pressed
                  hoverColor: Colors.blue, // tab button hover color
                  haptic: true, // haptic feedback
                  tabBorderRadius: 15,
                  tabActiveBorder: Border.all(
                      color: Colors.black, width: 1), // tab button border
                  tabBorder: Border.all(
                      color: Colors.grey, width: 1), // tab button border
                  // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
                  backgroundColor: Colors.white,
                  curve: Curves.easeOutExpo, // tab animation curves
                  duration:
                      Duration(milliseconds: 900), // tab animation duration
                  gap: 8, // the tab button gap between icon and text
                  color: Colors.black, // unselected icon color
                  activeColor: Colors.blue, // selected icon and text color
                  iconSize: 24, // tab button icon size
                  tabBackgroundColor: Colors.blue
                      .withOpacity(0.1), // selected tab background color
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5), // navigation bar padding
                  tabs: [
                    GButton(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icons.home,
                      text: 'Home',
                      onPressed: () {
                        setState(() {
                          index = 0;
                        });
                      },
                    ),
                    GButton(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icons.notifications_active,
                      text: 'Thikr',
                      onPressed: () {
                        setState(() {
                          index = 1;
                        });
                      },
                    ),
                    GButton(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icons.location_on,
                      text: 'Location',
                      onPressed: () {
                        setState(() {
                          index = 2;
                        });
                      },
                    )
                  ])),
            )));
  }
}




// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';
// // import 'package:location/location.dart';
// import 'adanAPI.dart';
// import 'countryPage.dart';
// import 'hiveData.dart';
// import 'api.dart';
// // import 'package:geocoding/geocoding.dart' as geo;
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart' as geoc;

// import 'homePage.dart';

// void main() async {
//   await Hive.initFlutter();
//   // List<Placemark> placemarks =
//   //     await placemarkFromCoordinates(52.2165157, 6.9437819);
//   // print(placemarks);
//   var box = await Hive.openBox('myData');
//   API api = new API();
//   var adan = await api.getAdan("al qatif", "saudi arabia", new DateTime.now());
//   print(adan.data.timings.fajr);

//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: homePage(),
//   ));
//   // runApp(App());
// }

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       routerDelegate: _router.routerDelegate,
//       routeInformationParser: _router.routeInformationParser,

//     );
//   }

//   final GoRouter _router= GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         pageBuilder: (context, state) => homePage(key: state.pageKey),
//       ),
//       GoRoute(
//         path: '/country',
//         pageBuilder: (context, state) => countryPage(),
//       ),
//     ],
//   );

// }








// class homePage extends StatefulWidget {
//   homePage({super.key});

//   @override
//   State<homePage> createState() => _homePageState();
// }

// class _homePageState extends State<homePage> {
//   // void initState() async {
//   //   var latLong = await _getGeoLocationPosition();
//   //   var address =
//   //   await GetAddressFromLatLong(latLong.latitude, latLong.longitude);
//   //   print(address);
//   //   super.initState();
//   // }
//   // initState() {
//   //   super.initState();
//   //   asyncMethod();
//   // }

//   // void asyncMethod() async {
//   //   <var> latLong = await _getGeoLocationPosition(),(){
//   //     return "Fds";
//   //   };
//   //   var address = await GetAddressFromLatLong(latLong.latitude, latLong.longitude);
//   //   print(address);
//   //   // ....
//   // }

//   // Future<dynamic> MyLocation() async {
//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<List<String>> GetAddressFromLatLong() async {
//     try {
//       var cor = await _getGeoLocationPosition();
//       List<geoc.Placemark> placemarks =
//           await geoc.placemarkFromCoordinates(cor.latitude, cor.longitude);
//       if (placemarks != null && placemarks.isNotEmpty) {
//         geoc.Placemark place = placemarks[0];
//         return <String>[place.locality.toString(), place.country.toString()];
//       } else {
//         return <String>[];
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold();
//   // }
//   String city = "your city";
//   String country = "your country";
//   bool firsttime = true;
//   DateTime theDate = DateTime.now();
//   int currentIndex = 0;
//   final sceen=[
//     homePage(),
//     countryPage(),
//   ];

//   void refresh(String newCity, String newCountry) {
//     setState(() {
//       city = newCity;
//       country = newCountry;
//     });
//   }

//   void refreshDate(DateTime newDate) {
//     setState(() {
//       theDate = newDate;
//     });
//   }

//   bool isNextSalah(Adan snapShopt, String salah) {
//     DateTime now = DateTime.now();
//     // print(convDate(snapShopt.data.timings.fajr));
//     // if(snapShopt.data.timings.fajr.compareTo(now.hour.toString()+":"+now.minute.toString())==-1){
//     //   return "Fajr"==salah;
//     // } else if(snapShopt.data.timings.dhuhr.compareTo(now.hour.toString()+":"+now.minute.toString())==-1){
//     //   return "Dhuhr"==salah;
//     // } else if(snapShopt.data.timings.asr.compareTo(now.hour.toString()+":"+now.minute.toString())==-1){
//     //   return "Asr"==salah;
//     // } else if(snapShopt.data.timings.maghrib.compareTo(now.hour.toString()+":"+now.minute.toString())==-1){
//     //   return "Maghrib"==salah;
//     // } else if(snapShopt.data.timings.isha.compareTo(now.hour.toString()+":"+now.minute.toString())==-1){
//     //   return "Isha"==salah;
//     // }
//     // return false;

//     if (now.isBefore(convDate(snapShopt.data.timings.fajr))) {
//       return "Fajr" == salah;
//     } else if (now.isAfter(convDate(snapShopt.data.timings.fajr)) &&
//         now.isBefore(convDate(snapShopt.data.timings.dhuhr))) {
//       return "Dhuhr" == salah;
//     } else if (now.isAfter(convDate(snapShopt.data.timings.dhuhr)) &&
//         now.isBefore(convDate(snapShopt.data.timings.asr))) {
//       return "Asr" == salah;
//     } else if (now.isAfter(convDate(snapShopt.data.timings.asr)) &&
//         now.isBefore(convDate(snapShopt.data.timings.maghrib))) {
//       return "Maghrib" == salah;
//     } else if (now.isAfter(convDate(snapShopt.data.timings.maghrib)) &&
//         now.isBefore(convDate(snapShopt.data.timings.isha))) {
//       return "Isha" == salah;
//     }

//     return false;
//   }

//   DateTime convDate(String toConv) {
//     DateTime now = DateTime.now();
//     DateTime dateTime =
//         DateFormat("yyyy-MM-dd HH:mm").parse("2023-01-01 $toConv");
//     DateTime dateTimeWithDate =
//         DateTime(now.year, now.month, now.day, dateTime.hour, dateTime.minute);
//     return dateTimeWithDate;
//   }

//   Widget build(BuildContext context) {
//     hiveData hive = new hiveData();
//     hive.deleteAllData();

//     // Future<List<String>> getKeys() async {
//     //   keys = await hive.getKeys();
//     //   print(keys);
//     //   return keys;
//     // }

//     // fuckKeys() async{

//     // }
//     // var test=getKeys();

//     // var keys = getKeys();

//     // void _showDate() async {
//     //    theDate = await showDatePicker(
//     //       context: context,
//     //       initialDate: theDate,
//     //       firstDate: DateTime(2000),
//     //       lastDate: DateTime(DateTime.now().year + 5));
//     // }
//     API api = new API();
//     return FutureBuilder(
//         future: GetAddressFromLatLong(),
//         builder: (context, snapshot) {
//           print("in the bulider");
//           if (snapshot.connectionState == ConnectionState.waiting &&
//               firsttime) {
//             return Center(child: const CircularProgressIndicator());
//           } else if (snapshot.hasError && firsttime) {
//             return Text("Error: ${snapshot.error}");
//           } else {
//             // if (firsttime) {
//             print("in the first time");
//             city = snapshot.data
//                 .toString()
//                 .substring(1, snapshot.data.toString().indexOf(','));
//             country = snapshot.data.toString().substring(
//                 snapshot.data.toString().indexOf(',') + 1,
//                 snapshot.data.toString().length - 1);
//             // }
//             firsttime = false;

//             // country = snapshot.data.toString().substring(
//             //     snapshot.data.toString().indexOf(',') + 1,
//             //     snapshot.data.toString().length - 1);

//             print("the city $city");
//             print("the country $country");

//             return FutureBuilder(
//                 future: api.getAdan(city, country, theDate),
//                 builder: (context, snapshot) {
//                   print("in the bulider");
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: const CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text("Error: ${snapshot.error}");
//                   } else {
//                     print(snapshot.data!.data.timings.asr);
//                     return (Scaffold(
//                         backgroundColor: Colors.white,
//                         appBar: AppBar(
//                             backgroundColor: Colors.white,
//                             elevation: 0,
//                             // title: Text('My adan',
//                             // style: TextStyle(
//                             //             fontSize: 24,
//                             //             color: Colors.black,
//                             //           )),
//                             centerTitle: true,
//                             leading: IconButton(
//                               icon: const Icon(Icons.date_range),
//                               color: Colors.black,
//                               onPressed: () async {
//                                 DateTime? newDate = await showDatePicker(
//                                     context: context,
//                                     initialDate: theDate,
//                                     firstDate: DateTime(2000),
//                                     lastDate:
//                                         DateTime(DateTime.now().year + 5));
//                                 if (newDate != null) {
//                                   theDate = newDate;
//                                 }
//                                 if (newDate != null) {
//                                   // && newDate != theDate) {
//                                   refreshDate(newDate);
//                                   print("the date is $theDate");
//                                 }
//                               },
//                             ),
//                             actions: [
//                               PopupMenuButton(
//                                 // icon: Icon(Icons.keyboard_arrow_down_sharp),
//                                 // color: Theme.of(context).primaryColor,
//                                 // child: Text('My Location'),

//                                 // offset: const Offset(0, 40),
//                                 child: (TextButton.icon(
//                                   label: Text(
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       color: Colors.black,
//                                     ),
//                                     {
//                                       if (city != "your city")
//                                         city
//                                       else
//                                         snapshot.data.toString().substring(
//                                             1,
//                                             snapshot.data
//                                                 .toString()
//                                                 .indexOf(","))
//                                     }
//                                         .toString()
//                                         .replaceAll("}", "")
//                                         .replaceAll("{", ""),
//                                   ),
//                                   icon: Icon(
//                                     Icons.keyboard_arrow_down_sharp,
//                                     // color: Theme.of(context).primaryColor,
//                                   ),
//                                   onPressed: null,
//                                 )),
//                                 itemBuilder: (context) {
//                                   if (city == "your city")
//                                     city = snapshot.data.toString().substring(1,
//                                         snapshot.data.toString().indexOf(","));

//                                   hive.saveData(city, country);
//                                   print("\n the shit:");
//                                   var keys = hive.getKeys();
//                                   // print(keys);
//                                   // print(keys.toString());
//                                   return [
//                                     for (var i = 0; i < keys.length; i++)
//                                       PopupMenuItem(
//                                           onTap: () {
//                                             refresh(hive.getData(keys[i])[0],
//                                                 hive.getData(keys[i])[1]);
//                                           },
//                                           value: hive.getData(keys[i][0]),
//                                           // child: Text("${hive.getData(keys[i])[0]}"),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 '${hive.getData(keys[i])[0]}',
//                                                 // style: product,
//                                               ),
//                                               // Text("data"),
//                                               Row(
//                                                 children: [
//                                                   // Image.asset(
//                                                   //   'assets/mile.png',
//                                                   //   height: 16,
//                                                   // ),
//                                                   SizedBox(
//                                                     width: 4,
//                                                   ),
//                                                   Text(
//                                                       '${hive.getData(keys[i])[1]}',
//                                                       style: TextStyle(
//                                                         fontSize: 12,
//                                                       )),
//                                                 ],
//                                               ),
//                                             ],
//                                           ))
//                                   ];
//                                 },
//                                 // onSelected: (value) {
//                                 //   var keys = hive.getKeys();
//                                 //   print("aaaaaaaaaaaaaaaaaaaaaaa");
//                                 //   print(value);
//                                 //   print("aaaaaaaaaaaaaaaaaaaaaaa");

//                                 //   for (var i = 0; i < keys.length; i++) {
//                                 //     if (value == hive.getData(keys[i][0])) {
//                                 //       refresh(hive.getData(keys[i][0])[0],
//                                 //           hive.getData(keys[i][0])[1]);
//                                 //     }
//                                 //   }
//                                 // }
//                               )
//                             ]),
//                         body: Column(
//                           children: [
//                             // Text(snapshot.data.toString()),
//                             // myCard(),
//                             Center(
//                                 child: Image.asset("assets/blue.png",
//                                     width: 300.0, height: 300.0)),
//                             Text(
//                                 " ${snapshot.data?.data.date.hijri.weekday.en} ${snapshot.data?.data.date.hijri.day} ${snapshot.data?.data.date.hijri.month.en}",
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   color: Colors.black,
//                                 )),

//                             adanCard(
//                                 "Fajr",
//                                 snapshot.data!.data.timings.fajr,
//                                 Icon(Icons.wb_sunny_outlined),
//                                 isNextSalah(snapshot.data!, "Fajr")),
//                             adanCard(
//                                 "Dhuhr",
//                                 snapshot.data!.data.timings.dhuhr,
//                                 Icon(Icons.sunny),
//                                 isNextSalah(snapshot.data!, "Dhuhr")),
//                             adanCard(
//                                 "Asr",
//                                 snapshot.data!.data.timings.asr,
//                                 Icon(Icons.sunny_snowing),
//                                 isNextSalah(snapshot.data!, "Asr")),
//                             adanCard(
//                                 "Maghrib",
//                                 snapshot.data!.data.timings.maghrib,
//                                 Icon(Icons.nightlight_round),
//                                 isNextSalah(snapshot.data!, "Maghrib")),
//                             adanCard(
//                                 "Isha",
//                                 snapshot.data!.data.timings.isha,
//                                 Icon(Icons.nights_stay),
//                                 isNextSalah(snapshot.data!, "Isha")),
//                             // IconButton(
//                             //     onPressed: () async {
//                             //       print(theDate.toString().substring(0, 10));

//                             //       // var latLong = await _getGeoLocationPosition();
//                             //       // var address = await GetAddressFromLatLong(
//                             //       //     latLong.latitude, latLong.longitude);
//                             //       // print(address);
//                             //       print(city);
//                             //       // refresh("newCity");
//                             //       print(city);

//                             //       // GetAddressFromLatLong(await getpos)
//                             //       // Position position = await _getGeoLocationPosition();
//                             //       // print(position);
//                             //       // print(GetAddressFromLatLong(position));

//                             //       // var my = await MyLocation();
//                             //       // print(my);
//                             //     },
//                             //     icon: Icon(Icons.print))
  

//                           ],
//                         ),
//                       bottomNavigationBar: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: (GNav(
//                                   rippleColor: Colors
//                                       .grey, // tab button ripple color when pressed
//                                   hoverColor:
//                                       Colors.blue, // tab button hover color
//                                   haptic: true, // haptic feedback
//                                   tabBorderRadius: 15,
//                                   tabActiveBorder: Border.all(
//                                       color: Colors.black,
//                                       width: 1), // tab button border
//                                   tabBorder: Border.all(
//                                       color: Colors.grey,
//                                       width: 1), // tab button border
//                                   // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
//                                   backgroundColor: Colors.white,
//                                   curve:
//                                       Curves.easeOutExpo, // tab animation curves
//                                   duration: Duration(
//                                       milliseconds:
//                                           900), // tab animation duration
//                                   gap:
//                                       8, // the tab button gap between icon and text
//                                   color: Colors.black, // unselected icon color
//                                   activeColor:
//                                       Colors.blue, // selected icon and text color
//                                   iconSize: 24, // tab button icon size
//                                   tabBackgroundColor: Colors.blue.withOpacity(
//                                       0.1), // selected tab background color
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 15,
//                                       vertical: 5), // navigation bar padding
//                                   tabs: [
//                                     GButton(
//                                       margin: EdgeInsets.symmetric(horizontal: 5),
//                                       icon: Icons.home,
//                                       text: 'Home',
//                                       onPressed: (index)=>Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (context) => homePage()),
//                                       ),
//                                     ),
//                                     GButton(
//                                       margin: EdgeInsets.symmetric(horizontal: 5),
//                                       icon: Icons.notifications_active,
//                                       text: 'Thikr',
//                                     ),
//                                     GButton(
//                                       margin: EdgeInsets.symmetric(horizontal: 5),
//                                       icon: Icons.location_on,
//                                       text: 'Location',
//                                       onPressed: (index)=>Navigator.push(
//                                         context,
//                                         MaterialPageRoute(builder: (context) => countryPage()),
//                                       ),
//                                     ),
//                                   ])),
//                       ),
//                       )
                    
//                     );
//                   }
//                 });
//           }
//         });
//   }

//   // Widget myTable() {
//   Widget myCard() {
//     return Card(
//       margin: const EdgeInsets.all(20),
//       elevation: 20,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//             // color: Theme.of(context).colorScheme.outline,
//             ),
//         borderRadius: const BorderRadius.all(Radius.circular(12)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(

//             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text("Fajer"),
//               Text("45"),
//               Text("20;20"),
//             ]),
//       ),
//     );
//   }

//   Widget adanCard(String salah, String time, Icon icon, bool isNextSalah) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       // Text(
//       //   'New Cars',
//       //   // style: header,
//       // ),
//       SizedBox(
//         height: 12,
//       ),
//       Container(
//         margin: const EdgeInsets.only(top: 0, left: 10, right: 20, bottom: 0),
//         width: double.infinity,
//         padding: EdgeInsets.only(
//           top: 10,
//           left: 10,
//           right: 20,
//           bottom: 10,
//         ),
//         decoration: BoxDecoration(
//           color: isNextSalah ? Colors.blue : Colors.white,
//           border: Border.all(
//             color: Color.fromARGB(255, 21, 151, 211),
//           ),
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Row(
//           children: [
//             icon,
//             // Image.asset(
//             //   'assets/porsche.png',
//             //   height: 60,
//             // ),
//             SizedBox(
//               width: 12,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.black,
//                   ),
//                   salah,
//                   // style: product,
//                 ),
//                 // Text("data"),
//                 // Row(
//                 //   children: [
//                 //     // Image.asset(
//                 //     //   'assets/mile.png',
//                 //     //   height: 16,
//                 //     // ),
//                 //     // SizedBox(
//                 //     //   width: 4,
//                 //     // ),
//                 //     // Text(
//                 //     //   '99 miles',
//                 //     //   // style: small,
//                 //     // ),
//                 //   ],
//                 // ),
//               ],
//             ),
//             Spacer(),
//             Text(
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.black,
//                 ),
//                 isNextSalah
//                     ? new DateTime.now()
//                             .difference(convDate(time))
//                             .inHours
//                             .toString() +
//                         ":" +
//                         (new DateTime.now()
//                                         .difference(convDate(time))
//                                         .inMinutes %
//                                     60 ==
//                                 0
//                             ? "0" +
//                                 new DateTime.now()
//                                     .difference(convDate(time))
//                                     .inMinutes
//                                     .toString()
//                             : (new DateTime.now()
//                                         .difference(convDate(time))
//                                         .inMinutes %
//                                     60)
//                                 .toString())
//                     : ""),
//             Spacer(),
//             Text(
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Colors.black,
//               ),
//               time,
//               // style: subheader,
//             ),
//           ],
//         ),
//       )
//     ]);
//   }
// }

























// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // Try running your application with "flutter run". You'll see the
// //         // application has a blue toolbar. Then, without quitting the app, try
// //         // changing the primarySwatch below to Colors.green and then invoke
// //         // "hot reload" (press "r" in the console where you ran "flutter run",
// //         // or simply save your changes to "hot reload" in a Flutter IDE).
// //         // Notice that the counter didn't reset back to zero; the application
// //         // is not restarted.
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});

// //   // This widget is the home page of your application. It is stateful, meaning
// //   // that it has a State object (defined below) that contains fields that affect
// //   // how it looks.

// //   // This class is the configuration for the state. It holds the values (in this
// //   // case the title) provided by the parent (in this case the App widget) and
// //   // used by the build method of the State. Fields in a Widget subclass are
// //   // always marked "final".

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   int _counter = 0;

// //   void _incrementCounter() {
// //     setState(() {
// //       // This call to setState tells the Flutter framework that something has
// //       // changed in this State, which causes it to rerun the build method below
// //       // so that the display can reflect the updated values. If we changed
// //       // _counter without calling setState(), then the build method would not be
// //       // called again, and so nothing would appear to happen.
// //       _counter++;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above.
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // Here we take the value from the MyHomePage object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         // Center is a layout widget. It takes a single child and positions it
// //         // in the middle of the parent.
// //         child: Column(
// //           // Column is also a layout widget. It takes a list of children and
// //           // arranges them vertically. By default, it sizes itself to fit its
// //           // children horizontally, and tries to be as tall as its parent.
// //           //
// //           // Invoke "debug painting" (press "p" in the console, choose the
// //           // "Toggle Debug Paint" action from the Flutter Inspector in Android
// //           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// //           // to see the wireframe for each widget.
// //           //
// //           // Column has various properties to control how it sizes itself and
// //           // how it positions its children. Here we use mainAxisAlignment to
// //           // center the children vertically; the main axis here is the vertical
// //           // axis because Columns are vertical (the cross axis would be
// //           // horizontal).
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text(
// //               'You have pushed the button this many times:',
// //             ),
// //             Text(
// //               '$_counter',
// //               style: Theme.of(context).textTheme.headlineMedium,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ), // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }
