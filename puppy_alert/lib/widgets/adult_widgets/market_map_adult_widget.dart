import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MarketMapAdultWidget extends StatelessWidget {
  final NLatLng _userLatLng;
  final Set<NMarker> _markerSet;

  const MarketMapAdultWidget(
      {super.key, required userLatLng, required markerSet})
      : _userLatLng = userLatLng,
        _markerSet = markerSet;

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        locationButtonEnable: true,
        indoorEnable: false,
        initialCameraPosition: NCameraPosition(
          target: _userLatLng,
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
      ),
      onMapReady: (NaverMapController controller) {
        if (_markerSet.isNotEmpty) {
          controller.addOverlayAll(_markerSet);
        }
      },
    );
  }
}
