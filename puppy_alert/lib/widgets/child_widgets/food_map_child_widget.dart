import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/models/food_model.dart';

class FoodMapChildWidget extends StatefulWidget {
  final List<FoodModel> _foodList;
  final Set<NMarker> _markerSet;
  final NLatLng _latLng;

  FoodMapChildWidget(
      {super.key, required markerSet, required foodList, required latitude, required longitude})
      : _markerSet = markerSet,
        _foodList = foodList,
        _latLng = NLatLng(latitude, longitude);

  @override
  State<FoodMapChildWidget> createState() => _FoodMapChildWidgetState();
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {

  void _setMarkerInfo() {
    for (NMarker marker in widget._markerSet) {
      for(FoodModel food in widget._foodList) {
        if (marker.info.id == food.foodId.toString()) {
          NInfoWindow infoWindow = NInfoWindow.onMarker(id: marker.info.id, text: food.menuName);
          marker.openInfoWindow(infoWindow);
        }
      }
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
