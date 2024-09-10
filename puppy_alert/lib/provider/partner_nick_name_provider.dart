import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PartnerNickNameProvider with ChangeNotifier{
  final String _userId;
  String _partnerNickName ='';

  PartnerNickNameProvider(this._userId){
    _fetchPartnerNickName();
  }

  void _fetchPartnerNickName() async {
    http.Response response = await http.get(Uri.parse('${dotenv.get('BASE_URL')}/user/day?userId=$_userId'));
    final Map<String, dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));

    _partnerNickName = jsonData['partnerNickName'] ?? '';
    notifyListeners();
  }

  String getPartnerNickName(){
    return _partnerNickName;
  }
}