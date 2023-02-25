import 'package:adan/Thikr.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'Notifications.dart';
import 'adanAPI.dart';
import 'countryPage.dart';
import 'hiveData.dart';
import 'api.dart';

import 'homePage.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('myData');
  API api = new API();
  var adan = await api.getAdan("al qatif", "saudi arabia", new DateTime.now());
  print(adan.data.timings.fajr);

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
