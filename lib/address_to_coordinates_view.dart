import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttergooglemap/button.dart';
import 'package:geocoding/geocoding.dart';

class AddressToCoordinatesScreen extends StatefulWidget {
  const AddressToCoordinatesScreen({super.key});

  @override
  State<AddressToCoordinatesScreen> createState() =>
      _AddressToCoordinatesScreenState();
}

class _AddressToCoordinatesScreenState
    extends State<AddressToCoordinatesScreen> {
  final TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();
    address.text = 'Gronausestraat 710, Enschede';
  }

  ValueNotifier<Location?> coordinate = ValueNotifier(null);

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
              valueListenable: coordinate,
              builder: (_, v, c) {
                return Text(
                  "latitude: ${v?.latitude ?? ''}\n longitude: ${v?.longitude ?? ''}",
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: address,
            decoration: const InputDecoration(
              label: Text('Address'),
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
            onTap: () => getCoordinatesFromAddress(address.text.trim()),
          )
        ],
      ),
    );
  }

  Future<void> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        log('${location.latitude}, ${location.longitude}');

        coordinate.value = location;
        log(coordinate.value.toString());
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
