import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/models/food_model.dart';

class FoodMapPuppyWidget extends StatefulWidget {
  final Set<NMarker> _markerSet;
  final Set<FoodModel> _foodSet;
  final NLatLng _userLatLng;

  const FoodMapPuppyWidget(
      {super.key,
      required Set<NMarker> markerSet,
      required Set<FoodModel> foodSet,
      required NLatLng userLatLng})
      : _markerSet = markerSet,
        _foodSet = foodSet,
        _userLatLng = userLatLng;

  @override
  State<FoodMapPuppyWidget> createState() => _FoodMapPuppyWidgetState();
}

class _FoodMapPuppyWidgetState extends State<FoodMapPuppyWidget> {
  void _addOpenInfoWindow(Set<NMarker> markerSet) {
    for (NMarker marker in markerSet) {
      for (FoodModel foodModel in widget._foodSet) {
        if (marker.info.id == foodModel.foodId.toString()) {
          marker.openInfoWindow(NInfoWindow.onMarker(
              id: marker.info.id, text: foodModel.menuName));
        }
      }
    }
  }

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
          _addOpenInfoWindow(widget._markerSet);
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
