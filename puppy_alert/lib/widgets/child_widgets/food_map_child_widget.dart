import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class FoodMapChildWidget extends StatefulWidget {
  final Set<NMarker> _markerSet;
  final NLatLng _latLng;

  FoodMapChildWidget(
      {super.key, required markerSet, required latitude, required longitude})
      : _markerSet = markerSet,
        _latLng = NLatLng(latitude, longitude);

  @override
  State<FoodMapChildWidget> createState() => _FoodMapChildWidgetState();
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {
  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: widget._latLng,
          zoom: 14,
          bearing: 0,
          tilt: 0,
        ),
        zoomGesturesEnable: true,
        extent: const NLatLngBounds(
          southWest: NLatLng(31.43, 122.37),
          northEast: NLatLng(44.35, 132.0),
        ),
      ),
      onMapReady: (NaverMapController controller) {
        if (widget._markerSet.isNotEmpty) {
          controller.addOverlay(
              NCircleOverlay(id: 'id', center: widget._latLng, radius: 500, outlineWidth: 0.5, color: Colors.transparent));
          controller.addOverlayAll(widget._markerSet);
        }
      },
      // 지도에 임의의 점을 눌렀을 때 좌표 반환 코드
      // onMapTapped: (NPoint point, NLatLng latLng) {
      //   print('latitude = ${latLng.latitude}');
      //   print('longitude = ${latLng.longitude}');
      // },
    );
  }
}
