import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class CustomMarkersView extends StatefulWidget {
  const CustomMarkersView({super.key});

  @override
  State<CustomMarkersView> createState() => _CustomMarkersViewState();
}

class _CustomMarkersViewState extends State<CustomMarkersView> {
  Completer<GoogleMapController> googleMapController = Completer();

  List<String> images = [
    'assets/car.png',
    'assets/bike.png',
    'assets/car.png',
    'assets/bike.png',
    'assets/car.png',
    'assets/bike.png',
  ];

  final Set<Marker> _markers = <Marker>{};

  final List<LatLng> _LatLang = const <LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.7088, 72.9682),
    LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771),
    LatLng(33.6910, 72.9807),
    LatLng(33.7036, 72.9785),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadMarkers();
    });
  }

  loadMarkers() async {
    for (var i = 0; i < images.length; i++) {
      _markers.add(
        Marker(
          icon: BitmapDescriptor.fromBytes(
            await loadAssetAsUint8List(
              images[i],
            ),
            size: const Size(
              15,
              15,
            ),
          ),
          markerId: MarkerId('$i'),
          position: _LatLang[i],
          infoWindow: InfoWindow(
            title: 'This is title marker $i',
          ),
        ),
      );
    }

    setState(() {});
  }

  Future<Uint8List> loadAssetAsUint8List(String path) async {
    ByteData byteData = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
        targetHeight: 100);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void dispose() {
    super.dispose();
    disposeController();
  }

  void disposeController() async {
    final controller = await googleMapController.future;
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        onMapCreated: (c) => googleMapController.complete(c),
        initialCameraPosition: CameraPosition(
          target: _LatLang[0],
          zoom: 13,
        ),
      ),
    );
  }
}
