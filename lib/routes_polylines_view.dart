import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class RoutePolyLineView extends StatefulWidget {
  const RoutePolyLineView({super.key});

  @override
  State<RoutePolyLineView> createState() => _RoutePolyLineViewState();
}

class _RoutePolyLineViewState extends State<RoutePolyLineView> {
  Completer<GoogleMapController> googleMapController = Completer();

  final List<Polyline> _polyline = [];
  final List<Marker> _marker = [];

  final List<LatLng> _LatLang = const <LatLng>[
    LatLng(24.862190816986804, 67.03024235564462),
    LatLng(24.863692834563295, 67.03302226447472),
    LatLng(24.8666117976744, 67.03855084696515),
    LatLng(24.870055677027775, 67.04281116214709),
    LatLng(24.87219224653031, 67.04253355350139),
    LatLng(24.872245781965805, 67.04275806756925),
    LatLng(24.870481486782058, 67.04764824710779),
    LatLng(24.864251664237006, 67.05702524982439),
    LatLng(24.86241765345951, 67.05833878165792),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addPolyLine();
    });
  }

  addPolyLine() {
    _marker.addAll([
      Marker(
        markerId: const MarkerId('1'),
        position: _LatLang.first,
        infoWindow: const InfoWindow(title: 'My Current Location'),
      ),
      Marker(
        markerId: const MarkerId('2'),
        position: _LatLang.last,
        infoWindow: const InfoWindow(title: 'My Current Location'),
      ),
    ]);

    _polyline.add(
      Polyline(
        polylineId: const PolylineId('1'),
        color: Colors.orange,
        points: _LatLang,
        
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
        markers: Set<Marker>.of(_marker),
        polylines: Set<Polyline>.of(_polyline),
        initialCameraPosition: CameraPosition(
          target: _LatLang[0],
          zoom: 14,
        ),
      ),
    );
  }
}
