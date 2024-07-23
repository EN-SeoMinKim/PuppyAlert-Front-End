import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import '../../widgets/child_widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/child_widgets/zipbob_widget.dart';

class ZipbobChildScreen extends StatefulWidget {
  const ZipbobChildScreen({super.key});

  @override
  State<ZipbobChildScreen> createState() => _ZipbobChildScreenState();
}

class _ZipbobChildScreenState extends State<ZipbobChildScreen> {
  late Future<void> _mapInitialization;

  @override
  void initState() {
    super.initState();
    _mapInitialization = _initNaverMap();
  }

  Future<void> _initNaverMap() async {
    await dotenv.load(fileName: '.env');
    String id = dotenv.get('CLIENT_ID');

    WidgetsFlutterBinding.ensureInitialized();
    await NaverMapSdk.instance.initialize(
      clientId: id,
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('신청 완료',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xffFF7700),
          ),),
          content: Text('\n신청이 완료되었습니다.\nhost가 수락할 때까지 잠시만 기다려주세요!',
          style: TextStyle(
            height: 2.0
          )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인',
              style: TextStyle(
                color: Color(0xffFF7700),
              )),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: Center(
              child: Text(
                '집밥',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[100],
            child: greyContainer(),
          ),
          Container(
            height: 130,
            child: firstFoodWidget(),
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 70,
                  child: TextButton(
                    onPressed: () {
                      _showConfirmationDialog();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffFFF1E4),
                    ),
                    child: Text(
                      '신청',
                      style: TextStyle(
                        color: Color(0xffFF7700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[100],
            child: greyContainer(),
          ),
          Container(
            height: 10,
            color: Colors.white,
          ),
          Container(
            height: 300,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xffFF7700),
                    ),
                    SizedBox(width: 10),
                    Text('주소 입력할 부분!!')
                  ],
                ),
                SizedBox(height: 30),
                FutureBuilder(
                  future: _mapInitialization,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: 300,
                        height: 200,
                        child: Stack(
                          children: [
                            NaverMap(
                              options: NaverMapViewOptions(
                                pickTolerance: 8,
                                indoorEnable: false,
                                locationButtonEnable: true,
                                scrollGesturesEnable: true,
                                consumeSymbolTapEvents: true,
                                initialCameraPosition: NCameraPosition(
                                  target: NLatLng(37.5666, 126.979),
                                  zoom: 10,
                                  bearing: 0,
                                  tilt: 0,
                                ),
                                mapType: NMapType.basic,
                                activeLayerGroups: [
                                  NLayerGroup.building,
                                  NLayerGroup.transit
                                ],
                              ),
                              onMapReady: (controller) {
                                final symbol = Symbol('asdf');
                                final marker = NMarker(
                                    id: 'test',
                                    position: NLatLng(37.506932467450326,
                                        127.05578661133796));
                                final marker1 = NMarker(
                                    id: 'test1',
                                    position: NLatLng(37.606932467450326,
                                        127.05578661133796));
                                controller.addOverlayAll({marker, marker1});
                                final OnMarkerInfoMap = NInfoWindow.onMarker(
                                    id: marker.info.id, text: "웅이네 떡볶이");
                                marker.openInfoWindow(OnMarkerInfoMap);
                              },
                              onMapTapped: (point, latLng) {
                                debugPrint(
                                    "${latLng.latitude}、${latLng.longitude}");
                              },
                              onSymbolTapped: (NSymbolInfo symbol) {
                                debugPrint("${symbol}");
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[100],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

Widget greyContainer() {
  return Container(
    height: 20,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      border: Border.all(color: Colors.grey[200]!, width: 2.0),
    ),
  );
}
