import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class FoodMapChildWidget extends StatefulWidget {
  const FoodMapChildWidget({super.key});

  @override
  State<FoodMapChildWidget> createState() => _FoodMapChildWidgetState();
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {
  NaverMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _setLocation();
  }

  _setLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      if (_mapController != null) {
        _mapController!.updateCamera(
          NCameraUpdate.withParams(
              target: NLatLng(position.latitude, position.longitude)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: const NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(37.5666, 126.979),
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
        zoomGesturesEnable: true,
        extent: NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: (NaverMapController controller) {
        _mapController = controller;
      },
      onMapTapped: (NPoint point, NLatLng latLng) {
        print('===========================');
        print(latLng.toString());
        print('===========================');
      },
    );
  }
}
