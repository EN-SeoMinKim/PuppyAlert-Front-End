import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/models/market_model.dart';

class MarketMapHostWidget extends StatelessWidget {
  final NLatLng _userLatLng;
  final Set<MarketModel> _marketModel;

  const MarketMapHostWidget(
      {super.key, required userLatLng, required marketModel})
      : _userLatLng = userLatLng,
        _marketModel = marketModel;

  Set<NMarker> _getMarkerSet() {
    Set<NMarker> markerSet = {};

    for (MarketModel market in _marketModel) {
      NMarker marker = NMarker(
          position: NLatLng(market.latitude, market.longitude),
          id: market.id.toString());

      marker.openInfoWindow(
          NInfoWindow.onMarker(id: market.id.toString(), text: market.name));
      markerSet.add(marker);
    }
    return markerSet;
  }

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
        if (_marketModel.isNotEmpty) {
          controller.addOverlayAll(_getMarkerSet());
        }
      },
    );
  }
}
