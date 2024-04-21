import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition keke = CameraPosition(
    target: LatLng(13.8021278, 100.3112839),
    zoom: 20.42,
  );

  static const CameraPosition mahidol = CameraPosition(
    target: LatLng(13.7937291, 100.3261972),
    zoom: 16.33,
  );

  final List<Marker> _markers = [
    Marker(
      markerId: MarkerId('Mahidol'),
      position: LatLng(13.7937291, 100.3261972),
      infoWindow: InfoWindow(
        title: 'Mahidol University'
      )
    ),
    Marker(
      markerId: MarkerId('Keke'),
      position: LatLng(13.8021278, 100.3112839),
      infoWindow: InfoWindow(
        title: 'Keke Condo'
      )
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: goKeke,
            tooltip: 'ไปยัง Keke',
          ),
          IconButton(
            icon: Icon(Icons.school),
            onPressed: goMahidol,
            tooltip: 'ไปยัง Mahidol',
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: keke,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(_markers),
      ),
    );
  }

  Future<void> goKeke() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(keke));
  }

  Future<void> goMahidol() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(mahidol));
  }
}