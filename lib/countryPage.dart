import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'hiveData.dart';

class countryPage extends StatefulWidget {
  const countryPage({Key? key}) : super(key: key);
  @override
  _countryPageState createState() => _countryPageState();
}

class _countryPageState extends State<countryPage> {
  hiveData hive = new hiveData();

  String theCity = "";
  String theState = "";
  String theCountry = "";

  bool _isButtonEnabled = false;
  late String _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country State City Picker"),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              CSCPicker(
                layout: Layout.vertical,
                flagState: CountryFlag.DISABLE,
                onCountryChanged: (country) {
                  theCountry =
                      removeDiacritics(country.toString().toLowerCase());
                },
                onStateChanged: (state) {
                  theState = removeDiacritics(state.toString().toLowerCase());
                },
                onCityChanged: (city) {
                  theCity = removeDiacritics(city.toString().toLowerCase());
                  setState(() {
                    _selectedValue = theCity;
                    _isButtonEnabled = _selectedValue != null;
                  });
                },

              
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),
                dropdownDialogRadius: 30,
                searchBarRadius: 30,
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  child: Text("Tap on this"),
                  style: ElevatedButton.styleFrom(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _isButtonEnabled
                      ? () {
                          hive.saveData(theCity, theCountry);
                          hive.getData(
                              theCity + ""  + "" + theCountry);
                        }
                      : null,
                ),
              ),
            ],
          )),
    );
  }
}
