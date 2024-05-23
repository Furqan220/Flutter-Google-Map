import 'package:flutter/material.dart';
import 'package:fluttergooglemap/address_to_coordinates_view.dart';
import 'package:fluttergooglemap/coordinates_to_address_screen_view.dart';
import 'package:fluttergooglemap/button.dart';
import 'package:fluttergooglemap/custom_info_window_view.dart';
import 'package:fluttergooglemap/custom_marker_with_network_image.dart';
import 'package:fluttergooglemap/custom_markers_view.dart';
import 'package:fluttergooglemap/google_map_view.dart';
import 'package:fluttergooglemap/google_search_places_api_view.dart';
import 'package:fluttergooglemap/my_location_marker_view.dart';
import 'package:fluttergooglemap/polygon_view.dart';
import 'package:fluttergooglemap/routes_polylines_view.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  final List<Option> options = const [
    Option('Google Map', GoogleMapView()),
    Option('Coordinates to Address', CoordinatesToAddressScreen()),
    Option('Query to Address', AddressToCoordinatesScreen()),
    Option('My Current Location', MyCurrentLocation()),
    Option('Search Location Api', GoogleSearchPlacesApi()),
    Option('Custom Markers', CustomMarkersView()),
    Option('Custom Info Window', CustomInfoWindowView()),
    Option('Polygon', PolygonView()),
    Option('Route PolyLine', RoutePolyLineView()),
    Option('Custom Marker Network Image', CustomMarkersNetworkView()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Google Map Index Screen'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 24,
        ),
        itemBuilder: (_, i) => CustomButton(
          title: options[i].title,
          onTap: () => goto(
            context,
            options[i].tab,
          ),
        ),
        separatorBuilder: (_, i) => const SizedBox(
          height: 20,
        ),
        itemCount: options.length,
      ),
    );
  }

  goto(BuildContext context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

class Option {
  final String title;
  final Widget tab;
  const Option(this.title, this.tab);
}
