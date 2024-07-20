import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class FoodMapChildWidget extends StatefulWidget {
  final NMarker? marker;

  const FoodMapChildWidget({super.key, this.marker});

  @override
  _FoodMapChildWidgetState createState() => _FoodMapChildWidgetState();
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {
  late Future<NLatLng> _futureLatLng;

  @override
  void initState() {
    super.initState();
    _futureLatLng = _setLocation();
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
      future: _futureLatLng,
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
              if (widget.marker != null) {
                controller.addOverlay(widget.marker!);
              }
            },
            onMapTapped: (NPoint point, NLatLng latLng) {},
          );
        } else {
          return const Center(child: Text('Unknown error'));
        }
      },
    );
  }
}