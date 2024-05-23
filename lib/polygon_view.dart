import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class PolygonView extends StatefulWidget {
  const PolygonView({super.key});

  @override
  State<PolygonView> createState() => _PlygonViewViewState();
}

class _PlygonViewViewState extends State<PolygonView> {
  Completer<GoogleMapController> googleMapController = Completer();

  final List<Polygon> _polygon = [];

  final List<LatLng> _LatLang = const <LatLng>[
    LatLng(24.877175, 67.042958),
    LatLng(24.884650, 67.057463),
    LatLng(24.87970461980197, 67.06545635521738),
    LatLng(24.864824226021586, 67.05571046776114),
    LatLng(24.870508925217024, 67.04772821352252),
    LatLng(24.872534, 67.048329),
    LatLng(24.877175, 67.042958),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addPolygon();
    });
  }

  addPolygon() async {
    _polygon.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: _LatLang,
        fillColor: Colors.red.withOpacity(0.2),
        strokeColor: Colors.red,
        visible: true,
        strokeWidth: 2,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (c) => googleMapController.complete(c),
        polygons: Set<Polygon>.of(_polygon),
        initialCameraPosition: CameraPosition(
          target: _LatLang[0],
          zoom: 14,
        ),
      ),
    );
  }
}
