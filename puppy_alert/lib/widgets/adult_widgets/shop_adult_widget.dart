import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:puppy_alert/models/market_model.dart';
import 'package:puppy_alert/models/shop_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ShopAdultWidget extends StatefulWidget {
  final List<MarketModel> _marketList;

  const ShopAdultWidget({super.key, required List<MarketModel> marketList})
      : _marketList = marketList;

  @override
  State<ShopAdultWidget> createState() => _ShopAdultWidgetState();
}

class _ShopAdultWidgetState extends State<ShopAdultWidget> {
  final List<ShopModel> _shopModelList = List.empty(growable: true);
  late String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = widget._marketList[0].name;
  }

  Future<List<MarketModel>> getMarketList() async {
    http.Response response =
    await http.get(Uri.parse('${dotenv.get('BASE_URL')}/market/all'));
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonData
        .map<MarketModel>((json) => MarketModel.fromJson(json))
        .toList();
  }

  void _initShopModelList() {

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: DropdownButton<String>(
              value: _dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                setState(() {
                  _dropdownValue = value!;
                });
              },
              items: widget._marketList
                  .map<DropdownMenuItem<String>>((MarketModel marketModel) {
                String value = marketModel.name;

                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
