import 'package:flutter/material.dart';
import 'package:mapapp/getuserlocation.dart';
import 'package:mapapp/map_page.dart';
import 'package:mapapp/mapscreen.dart';
import 'package:mapapp/transform_latlng.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: GetUserLocation());
  }
}
