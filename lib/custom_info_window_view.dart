import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class CustomInfoWindowView extends StatefulWidget {
  const CustomInfoWindowView({super.key});

  @override
  State<CustomInfoWindowView> createState() => _CustomInfoWindowViewState();
}

class _CustomInfoWindowViewState extends State<CustomInfoWindowView> {
  CustomInfoWindowController controller = CustomInfoWindowController();

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
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   loadMarkers();
    // });
  }

  loadMarkers() async {
    for (var i = 0; i < images.length; i++) {
      _markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarker,
          markerId: MarkerId('$i'),
          position: _LatLang[i],
          onTap: () => controller.addInfoWindow!(
            Container(
              // height: 300,
              // width: 300,
              // color: Colors.red,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://up.yimg.com/ib/th?id=OIP.kTvs-fiEdCw7rldk41rhKwHaEo&pid=Api&rs=1&c=1&qlt=95&w=170&h=106',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'This is the Custom window info for marker $i',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            _LatLang[i],
          ),
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: _markers,
            onMapCreated: (c) => controller.googleMapController = c,
            initialCameraPosition: CameraPosition(
              target: _LatLang[0],
              zoom: 13,
            ),
          ),
          CustomInfoWindow(
            controller: controller,
            height: 150,
            width: 200,
            offset: 35,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => loadMarkers(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
