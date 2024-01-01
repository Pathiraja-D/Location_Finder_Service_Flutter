import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> controller = Completer();
  static CameraPosition _initialPosition = CameraPosition(
    target: LatLng(7.8774222, 80.7003428),
    zoom: 14.4746,
  );

  final List<Marker> mymarker = [];
  final List<Marker> mymarkerList = [
    const Marker(
        markerId: MarkerId('First'),
        position: LatLng(7.8774222, 80.7003428),
        infoWindow: InfoWindow(title: 'First Marker')),
    const Marker(
        markerId: MarkerId('Second'), position: LatLng(7.8774222, 80.713428)),
  ];

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
        child: Icon(Icons.location_searching),
        onPressed: () async {
          GoogleMapController _controller = await controller.future;
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(7.8774222, 80.7003428), zoom: 14)),
          );
          setState(() {});
        },
      ),
    );
  }
}
