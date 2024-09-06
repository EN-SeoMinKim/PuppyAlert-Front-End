import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:puppy_alert/models/market_model.dart';
import 'package:puppy_alert/models/shop_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ShopHostScreen extends StatefulWidget {
  final Set<MarketModel> _marketSet;

  const ShopHostScreen({super.key, required Set<MarketModel> marketSet})
      : _marketSet = marketSet;

  @override
  State<ShopHostScreen> createState() => _ShopHostScreenState();
}

class _ShopHostScreenState extends State<ShopHostScreen> {
  final List<ShopModel> _shopModelList = List.empty(growable: true);
  late String _selectedMarketName;

  @override
  void initState() {
    super.initState();
    _selectedMarketName = widget._marketSet.first.name;
    _setShopModelList();
  }

  void _setShopModelList() async {
    http.Response response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/market/shops?marketId=${getMarketId()}'));
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      _shopModelList.clear();
      _shopModelList.addAll(
          jsonData.map<ShopModel>((json) => ShopModel.fromJson(json)).toList());
    });
  }

  int getMarketId() {
    return widget._marketSet
        .firstWhere((element) => element.name == _selectedMarketName)
        .id;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffFF7700),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Icon(Icons.shopping_cart_outlined),
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMarketName,
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.orange,
                        onChanged: (String? value) {
                          if (value != null && value != _selectedMarketName) {
                            setState(() {
                              _selectedMarketName = value;
                              _setShopModelList();
                            });
                          }
                        },
                        isExpanded: true,
                        items: widget._marketSet.map<DropdownMenuItem<String>>(
                            (MarketModel marketModel) {
                          return DropdownMenuItem<String>(
                            value: marketModel.name,
                            child: Text(marketModel.name),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _shopModelList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.store, size: 50),
                      title: Text(_shopModelList[index].name),
                      subtitle: Text(_shopModelList[index].detailAddress),
                      trailing: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          _shopModelList[index].productType,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xffED6931),
                              backgroundColor: Color(0xffFFF1E4)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
