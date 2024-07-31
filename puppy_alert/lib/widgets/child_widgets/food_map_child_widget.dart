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
  void initState() {
    super.initState();
  }

  void _setMarkerInfo() {
    for (NMarker marker in widget._markerSet) {
      NInfoWindow infoWindow = NInfoWindow.onMarker(id: marker.info.id, text: marker.info.id);
      marker.openInfoWindow(infoWindow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        locationButtonEnable: true,
        initialCameraPosition: NCameraPosition(
          target: widget._latLng,
          zoom: 15,
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
          controller.addOverlayAll(widget._markerSet);
          _setMarkerInfo();

          controller.addOverlay(NCircleOverlay(
              id: 'id',
              center: widget._latLng,
              radius: 500,
              outlineWidth: 3,
              outlineColor: Colors.orange,
              color: Colors.transparent));
        }
      },
    );
  }
}
