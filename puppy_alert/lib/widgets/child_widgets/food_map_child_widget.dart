import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class FoodMapChildWidget extends StatefulWidget {
  const FoodMapChildWidget({super.key});

  @override
  State<FoodMapChildWidget> createState() => _FoodMapChildWidgetState();
}

Future<void> _initNaverMap() async {
  await dotenv.load(fileName: '.env');
  String id = dotenv.get('CLIENT_ID');

  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: id, onAuthFailed: (error) => print('Auth failed: $error'));
}

class _FoodMapChildWidgetState extends State<FoodMapChildWidget> {
  NLatLng? _latLng;

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
      print('=== set location start ===');
      _latLng = NLatLng(position.latitude, position.longitude);
      print(_latLng?.latitude.toString());
      print('=== set location end ===');
    });
  }

  @override
  void initState() {
    super.initState();
    _setLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _initNaverMap(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (_latLng == null) {
              _latLng = NLatLng(37.5666, 126.979);
            }
            return NaverMap(
              options: NaverMapViewOptions(
                initialCameraPosition: NCameraPosition(
                  target: _latLng!,
                  zoom: 0,
                  bearing: 0,
                  tilt: 0,
                ),
                zoomGesturesEnable: true, // zoom in, out 가능
                extent: const NLatLngBounds(
                  // 지도 영역 한반도 인근으로 제한
                  southWest: NLatLng(31.43, 122.37),
                  northEast: NLatLng(44.35, 132.0),
                ),
              ),
              // onMapReady: (NaverMapController controller) {
              //
              // },
            );
          }
        });
  }
}