import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  String retroTheme = '';
  String aubergineTheme = '';
  String? theme;

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.887913, 67.0583857),
      infoWindow: InfoWindow(
        title: 'My Current Location',
      ),
    ),
  };

  Completer<GoogleMapController> googleMapController = Completer();

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  void getTheme() {
    DefaultAssetBundle.of(context)
        .loadString('assets/retro_theme.json')
        .then((theme) => retroTheme = theme);
    DefaultAssetBundle.of(context)
        .loadString('assets/aubergine_theme.json')
        .then((theme) => aubergineTheme = theme);
    log(retroTheme);
    log(aubergineTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: _markers,
        onMapCreated: (c) => googleMapController.complete(c),
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.887913, 67.0583857),
          zoom: 13,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: 30,
            child: PopupMenuButton<String>(
              color: Colors.brown,
              icon: const Icon(
                Icons.color_lens,
                color: Colors.white,
              ),
              onSelected: (String item) async {
                GoogleMapController _googleMapController =
                    await googleMapController.future;
                _googleMapController.setMapStyle(item);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '',
                  child: const Text('Standard Theme'),
                ),
                PopupMenuItem<String>(
                  value: retroTheme,
                  child: const Text('Retro Theme'),
                ),
                PopupMenuItem<String>(
                  value: aubergineTheme,
                  child: const Text('Aubergine Theme'),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            child: const Icon(Icons.location_searching_outlined),
            onPressed: () async {
              GoogleMapController _googleMapController =
                  await googleMapController.future;
              _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    target: LatLng(27.552888123610092, 68.20994851475363),
                    zoom: 13,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
