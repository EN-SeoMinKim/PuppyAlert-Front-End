import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class FoodMapChildWidget extends StatefulWidget {
  Set<NMarker>? _markerSet;

  FoodMapChildWidget({super.key});

  void setMarkerSet(Set<NMarker> markerSet) {
    _markerSet = markerSet;
  }

  @override
  _FoodMapChildWidgetState createState() => _FoodMapChildWidgetState();
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {
  late Future<NLatLng> _futureCameraPosition;

  @override
  void initState() {
    super.initState();
    _futureCameraPosition = _setLocation();
  }

  Future<NLatLng> _setLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return const NLatLng(37.5666, 126.979); // 위치 동의 거부 시 서울 시청 좌표 반환
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return NLatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NLatLng>(
      future: _futureCameraPosition,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: snapshot.data!,
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
              if (widget._markerSet != null) {
                controller.addOverlayAll(widget._markerSet!);
              }
            },

            // 지도에 임의의 점을 눌렀을 때 좌표 반환 코드
            onMapTapped: (NPoint point, NLatLng latLng) {
              print('latitude = ${latLng.latitude}');
              print('longitude = ${latLng.longitude}');
            },
          );
        } else {
          return const Center(child: Text('Unknown error'));
        }
      },
    );
  }
}
