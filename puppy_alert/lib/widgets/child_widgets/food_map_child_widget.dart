import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class FoodMapChildWidget extends StatefulWidget {
  NMarker marker;

  FoodMapChildWidget({super.key, required this.marker});

  @override
  State<FoodMapChildWidget> createState() => _FoodMapChildWidgetState(marker);
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {
  late NMarker _marker;
  NaverMapController? _mapController;

  _FoodMapChildWidgetState(NMarker marker) {
    this._marker = marker;
  }

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
    _setMapController(position);
  }

  _setMapController(Position position) {
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
        _mapController!.addOverlay(_marker);
      },

      onMapTapped: (NPoint point, NLatLng latLng) {
      },
    );
  }
}
