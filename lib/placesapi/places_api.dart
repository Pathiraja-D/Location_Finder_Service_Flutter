import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MyPlacesApiGoogleMapSearch extends StatefulWidget {
  const MyPlacesApiGoogleMapSearch({super.key});

  @override
  State<MyPlacesApiGoogleMapSearch> createState() =>
      _MyPlacesApiGoogleMapSearchState();
}

class _MyPlacesApiGoogleMapSearchState
    extends State<MyPlacesApiGoogleMapSearch> {
  final TextEditingController search = TextEditingController();
  String tokenForSession = '1948';
  List<dynamic> listOfPlaces = [];
  var uuid = Uuid();

  void makeSuggestion(String input) async {
    String googlePlacesApiKey = 'AIzaSyCCEax977Tl88T7wNZPPWYKyouXuVDRJvA';
    String groundUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$groundUrl?input=$input&key=$googlePlacesApiKey&sessiontoken=$tokenForSession';

    var response = await http.get(Uri.parse(request));

    var resultData = response.body.toString();

    print(resultData);

    if (response.statusCode == 200) {
      setState(() {
        listOfPlaces = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Showing Data Failed Try Again');
    }
  }

  void onModify() {
    if (tokenForSession == null) {
      setState(() {
        tokenForSession = uuid.v4();
      });
    }

    makeSuggestion(search.text);
  }

  @override
  void initState() {
    super.initState();
    search.addListener(() {
      onModify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Places API Google Map Search'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(children: [
            TextFormField(
              controller: search,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: listOfPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(
                              listOfPlaces[index]['description']);
                          print(locations.last.longitude);
                          print(locations.last.latitude);
                        },
                        title: Text(listOfPlaces[index]['description']),
                      );
                    }))
          ]),
        ),
      ),
    );
  }
}
