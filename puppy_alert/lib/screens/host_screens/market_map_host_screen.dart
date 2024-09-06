import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:puppy_alert/models/market_model.dart';
import 'package:puppy_alert/screens/host_screens/shop_host_screen.dart';

class MarketMapHostScreen extends StatelessWidget {
  final NLatLng _userLatLng;
  final Set<MarketModel> _marketSet;

  const MarketMapHostScreen(
      {super.key, required userLatLng, required Set<MarketModel> marketSet})
      : _userLatLng = userLatLng,
        _marketSet = marketSet;

  Set<NMarker> _getMarkerSet() {
    Set<NMarker> result = {};

    for (MarketModel market in _marketSet) {
      NMarker marker = NMarker(
          position: NLatLng(market.latitude, market.longitude),
          id: market.id.toString());

      result.add(marker);
    }
    return result;
  }

  void _onTappedMarker(BuildContext context, Set<NMarker> markerSet) {
    if (markerSet.isEmpty) return;

    for (var naverMarker in markerSet) {
      for (MarketModel market in _marketSet) {
        if (naverMarker.info.id == market.id.toString()) {
          naverMarker.setOnTapListener((NMarker marker) {

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShopHostScreen(
                  marketSet: {market},
                )));

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ShopHostScreen(
            //               marketSet: {market},
            //             )));
          });
        }
      }
    }
  }

  void _addOpenInfoWindow(Set<NMarker> naverMarkerSet) {
    for (NMarker marker in naverMarkerSet) {
      for (MarketModel marketModel in _marketSet) {
        if (marker.info.id == marketModel.id.toString()) {
          marker.openInfoWindow(
              NInfoWindow.onMarker(id: marker.info.id, text: marketModel.name));
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
          target: _userLatLng,
          zoom: 13,
          bearing: 0,
          tilt: 0,
        ),
      ),
      onMapReady: (NaverMapController controller) {
        if (_marketSet.isNotEmpty) {
          Set<NMarker> naverMarkerSet = _getMarkerSet();
          controller.addOverlayAll(naverMarkerSet);
          _onTappedMarker(context, naverMarkerSet);
          _addOpenInfoWindow(naverMarkerSet);
        }
      },
    );
  }
}
