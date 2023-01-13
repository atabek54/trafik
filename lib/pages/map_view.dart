import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(37.43296265331129, -122.08832357078792),
                  tilt: 59.440717697143555,
                  zoom: 19.151926040649414))),
    ));
  }
}
