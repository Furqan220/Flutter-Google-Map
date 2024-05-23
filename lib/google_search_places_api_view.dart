import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttergooglemap/model/place_prediction_model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlacesApi extends StatefulWidget {
  const GoogleSearchPlacesApi({super.key});

  @override
  State<GoogleSearchPlacesApi> createState() => _GoogleSearchPlacesApiState();
}

class _GoogleSearchPlacesApiState extends State<GoogleSearchPlacesApi> {
  final TextEditingController controller = TextEditingController();
  dynamic uuid = Uuid();
  ValueNotifier<List<PlacePredictionModel>> places = ValueNotifier([]);
  String? sessionToken;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      onChanged();
    });
  }

  void onChanged() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }
    places.value = [];

    if (controller.text.trim().isNotEmpty) {
      getSuggestions(controller.text.trim());
    }
  }

  void getSuggestions(String input) async {
    String apiKey = 'AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow';
    // String apiKey = 'AIzaSyB7dlmyqCFY9OZz2m4yW_DPuzt0NWekUPQ';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken';

    final response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      log(response.body.toString());
      final jsonBody = jsonDecode(response.body);
      List<PlacePredictionModel> _places = [];
      for (var p in jsonBody['predictions']) {
        _places.add(PlacePredictionModel(map: p));
      }
      places.value = _places;
      log(places.value.toString());
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Search Api'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: controller,
              decoration: const InputDecoration(
                label: Text('Search Places'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: places,
              builder: (_, places, c) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: places.length,
                  separatorBuilder: (_, i) => const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  itemBuilder: (_, i) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(places[i].description),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
