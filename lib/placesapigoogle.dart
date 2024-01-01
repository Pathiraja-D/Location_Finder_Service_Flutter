import 'package:flutter/material.dart';

class PlacesApiGoogleMapSearch extends StatefulWidget {
  const PlacesApiGoogleMapSearch({super.key});

  @override
  State<PlacesApiGoogleMapSearch> createState() =>
      _PlacesApiGoogleMapSearchState();
}

class _PlacesApiGoogleMapSearchState extends State<PlacesApiGoogleMapSearch> {
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              TextFormField(
                controller: search,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
