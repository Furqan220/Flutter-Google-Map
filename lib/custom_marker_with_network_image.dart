import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class CustomMarkersNetworkView extends StatefulWidget {
  const CustomMarkersNetworkView({super.key});

  @override
  State<CustomMarkersNetworkView> createState() =>
      _CustomMarkersNetworkViewState();
}

class _CustomMarkersNetworkViewState extends State<CustomMarkersNetworkView> {
  Completer<GoogleMapController> googleMapController = Completer();

  String image =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu5GX1lkI6T4INseXlhyZhaGMtq07LNid9Tw&s';

  final Set<Marker> _markers = <Marker>{};

  final List<LatLng> _LatLang = const <LatLng>[
    LatLng(33.6941, 72.9734),
    LatLng(33.7088, 72.9682),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadMarkers();
    });
  }

  loadMarkers() async {
    final Uint8List img = await loadNetworkAsUint8List(image);

    for (var i = 0; i < _LatLang.length; i++) {
      _markers.add(
        Marker(
          icon: BitmapDescriptor.fromBytes(
            img,
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

  Future<Uint8List> loadNetworkAsUint8List(String path) async {
    final completer = Completer<ImageInfo>();
    final image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;

    final ByteData? byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    ui.Codec codec = await ui.instantiateImageCodec(
      byteData!.buffer.asUint8List(),
      targetHeight: 100,
      targetWidth: 100,
    );
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
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
