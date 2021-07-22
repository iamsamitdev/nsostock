import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nsostock/utils/constants.dart';


class CallAPI {

  // กำหนด header ของ api
  _setHeaders() => {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };

  // สร้างฟังก์ชันในการ Login
  loginAPI(data) async {
    return await http.post(
      Uri.parse(baseAPIURL+'login'),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

}