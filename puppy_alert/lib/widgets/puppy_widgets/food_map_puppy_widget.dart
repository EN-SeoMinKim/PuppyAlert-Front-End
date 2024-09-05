import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class FoodMapPuppyWidget extends StatefulWidget {
  final Set<NMarker> _markerSet;
  final NLatLng _userLatLng;

  const FoodMapPuppyWidget(
      {super.key, required Set<NMarker> markerSet, required NLatLng userLatLng})
      : _markerSet = markerSet,
        _userLatLng = userLatLng;

  @override
  State<FoodMapPuppyWidget> createState() => _FoodMapPuppyWidgetState();
}

class _FoodMapPuppyWidgetState extends State<FoodMapPuppyWidget> {
  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        locationButtonEnable: true,
        indoorEnable: false,
        initialCameraPosition: NCameraPosition(
          target: widget._userLatLng,
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
        extent: const NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: (NaverMapController controller) {
        if (widget._markerSet.isNotEmpty) {
          controller.addOverlayAll(widget._markerSet);

          controller.addOverlay(NCircleOverlay(
              id: 'id',
              center: widget._userLatLng,
              radius: 500,
              outlineWidth: 3,
              outlineColor: Colors.orange,
              color: Colors.transparent));
        }
      },
    );
  }
}
