import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttergooglemap/button.dart';
import 'package:geocoding/geocoding.dart';

class CoordinatesToAddressScreen extends StatefulWidget {
  const CoordinatesToAddressScreen({super.key});

  @override
  State<CoordinatesToAddressScreen> createState() =>
      _CoordinatesToAddressScreenState();
}

class _CoordinatesToAddressScreenState
    extends State<CoordinatesToAddressScreen> {
  final TextEditingController latController = TextEditingController();
  final TextEditingController lngController = TextEditingController();

  @override
  void initState() {
    super.initState();
    latController.text = '-34.8399103';
    lngController.text = '-58.4629997';
  }

  ValueNotifier<String> address = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Coordinates to Address'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const SizedBox(
            height: 200,
          ),
          ValueListenableBuilder(
              valueListenable: address,
              builder: (_, v, c) {
                return Text(
                  v,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: latController,
            decoration: const InputDecoration(
              label: Text('Latitude'),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: lngController,
            decoration: const InputDecoration(
              label: Text('longitude'),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
              title: 'Convert',
              onTap: () => getAddressFromLatLng(
                  latController.text.trim(), lngController.text.trim()))
        ],
      ),
    );
  }

  Future<void> getAddressFromLatLng(String lat, String lng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(double.parse(lat), double.parse(lng));
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        log('${place.street}, ${place.country}');

        address.value = '${place.name}, ${place.street}, ${place.country}';
        log(address.value);
      }
    } catch (e) {
      if (e is PlatformException) {
        log('PlatformException: ${e.message}');
      } else {
        log('Unexpected error: $e');
      }
    }
  }
}
