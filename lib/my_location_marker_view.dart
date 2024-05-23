import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
  Set<Marker> markers = {};

  Completer<GoogleMapController> googleMapController = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCurrentLocation();
    });
  }

  void loadCurrentLocation() {
    getUserLocation().then((currentLocation) async {
      log(currentLocation.latitude.toString());
      log(currentLocation.longitude.toString());

      markers.add(
        Marker(
            markerId: const MarkerId('5'),
            position: LatLng(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
            infoWindow: const InfoWindow(title: 'My Location')),
      );
      CameraPosition cameraPositions = CameraPosition(
        target: LatLng(
          currentLocation.latitude,
          currentLocation.longitude,
        ),
        zoom: 15,
      );

      final GoogleMapController _controller = await googleMapController.future;
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          cameraPositions,
        ),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: markers,
        onMapCreated: (c) => googleMapController.complete(c),
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.887913, 67.0583857),
          zoom: 13,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.location_on),
      //   onPressed: () {
      // getUserLocation().then((currentLocation) async {
      //   log(currentLocation.latitude.toString());
      //   log(currentLocation.longitude.toString());

      //   markers.add(
      //     Marker(
      //         markerId: const MarkerId('5'),
      //         position: LatLng(
      //           currentLocation.latitude,
      //           currentLocation.longitude,
      //         ),
      //         infoWindow: const InfoWindow(title: 'My Location')),
      //   );
      //   CameraPosition cameraPositions = CameraPosition(
      //     target: LatLng(
      //       currentLocation.latitude,
      //       currentLocation.longitude,
      //     ),
      //     zoom: 15,
      //   );

      //   final GoogleMapController _controller =
      //       await googleMapController.future;
      //   _controller.animateCamera(
      //     CameraUpdate.newCameraPosition(
      //       cameraPositions,
      //     ),
      //   );
      //   setState(() {});
      // });
      //   },
      // ),
    );
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission().then((value) {
      log(value.toString());
    }).onError((error, stackTrace) {
      log(error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }
}
