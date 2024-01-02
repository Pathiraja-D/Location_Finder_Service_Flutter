import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({super.key});

  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  final Completer<GoogleMapController> controller = Completer();
  static CameraPosition _initialPosition = CameraPosition(
    target: LatLng(7.8774222, 80.7003428),
    zoom: 14.4746,
  );

  final List<Marker> mymarker = [];
  final List<Marker> mymarkerList = [
    const Marker(
        markerId: MarkerId('First'),
        position: LatLng(7.8974222, 80.7503428),
        infoWindow: InfoWindow(title: 'My Home')),
  ];

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error $error');
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  packData() {
    getUserLocation().then((value) async {
      print('My location');
      print('${value.latitude} ${value.longitude}');

      mymarker.add(
        Marker(
            markerId: MarkerId('Senod Marker'),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: InfoWindow(title: 'Second Marker')),
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);

      final GoogleMapController controller = await this.controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mymarker.addAll(mymarkerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(mymarker),
          onMapCreated: (GoogleMapController _controller) {
            controller.complete(_controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            packData();
          }),
    );
  }
}
