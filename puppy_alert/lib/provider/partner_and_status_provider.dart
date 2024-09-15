import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PartnerAndStatusProvider with ChangeNotifier {
  final String _userId;
  String _partnerNickName = '';
  String _status = '';
  bool _isDisposed = false;

  PartnerAndStatusProvider(this._userId);

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _fetchPartnerAndStatus() async {
    http.Response response = await http
        .get(Uri.parse('${dotenv.get('BASE_URL')}/user/day?userId=$_userId'));
    if (response.statusCode != 200) return;

    final Map<String, dynamic> jsonData =
        jsonDecode(utf8.decode(response.bodyBytes));

    if (_isDisposed) return;

    _partnerNickName = jsonData['partnerNickName'] ?? '';
    _status = jsonData['status'] ?? '';
    notifyListeners();
  }

  String getPartnerNickName() {
    _fetchPartnerAndStatus();
    return _partnerNickName;
  }

  String getStatus() {
    _fetchPartnerAndStatus();
    return _status;
  }
}
