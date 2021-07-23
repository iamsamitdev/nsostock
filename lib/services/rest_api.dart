import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nsostock/models/UserModel.dart';
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

  // สร้างฟังก์ชันสำหรับใช้ Register
  registerAPI(data) async {
    return await http.post(
      Uri.parse(baseAPIURL+'register'),
      body: jsonEncode(data),
      headers: _setHeaders()
    );
  }

  //สร้างฟังก์ชันในการอ่านข้อมูล Profile ผู้ใช้
  Future<UserModel?> getProfile(id) async {

    final response = await http.get(
      Uri.parse(baseAPIURL+'users/'+id),
      headers: _setHeaders()
    );

    // ignore: unnecessary_null_comparison
    if(response.body != null){
      return userModelFromJson(response.body);
    }else{
      return null;
    }

  }

}