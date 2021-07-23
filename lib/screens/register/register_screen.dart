import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nsostock/services/rest_api.dart';
import 'package:nsostock/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

    // สร้างตัวแปรไว้เก็บ username และ password
  String? _username, _password, _fullname;

  // สร้าง key เพื่อผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                style:
                                    TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      size: 28,
                                    ),
                                    labelText: 'ชื่อ-สกุล',
                                    hintText: 'กรุณาป้อนชื่อ-สกุล',
                                    hintStyle: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    errorStyle: TextStyle(fontSize: 16)
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'กรุณาป้อนชื่อ-สกุลก่อน';
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (value){
                                  _fullname = value!.trim();
                                },
                              ),
                              TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                style:
                                    TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.person,
                                      size: 28,
                                    ),
                                    labelText: 'ชื่อผู้ใช้',
                                    hintText: 'กรุณาป้อนชื่อผู้ใช้',
                                    hintStyle: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    errorStyle: TextStyle(fontSize: 16)
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'กรุณาป้อนชื่อผู้ใช้ก่อน';
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (value){
                                  _username = value!.trim();
                                },
                              ),
                              TextFormField(
                                autofocus: false,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                style:
                                    TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.lock,
                                      size: 28,
                                    ),
                                    labelText: 'รหัสผ่าน',
                                    hintText: 'กรุณาป้อนรหัสผ่าน',
                                    hintStyle: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    errorStyle: TextStyle(fontSize: 16)
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'กรุณาป้อนรหัสผ่านก่อน';
                                  }else{
                                    return null;
                                  }
                                },
                                onSaved: (value){
                                  _password = value!.trim();
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                onPressed: () async {

                                  if(formKey.currentState!.validate()){
                                    formKey.currentState!.save();
                                    
                                    // เรียกใช้ registerAPI
                                    var response = await CallAPI().registerAPI(
                                      {
                                        "fullname": _fullname,
                                        "username": _username,
                                        "password": _password,
                                        "img_profile": "noimg.jpg",
                                        "status":"1"
                                      }
                                    );

                                    var body = json.decode(response.body);

                                    if(body['status'] == 'success'){

                                      // สร้าง Object แบบ SharedPreferences
                                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                      // เก็บค่าที่ต้องการลงในตัวแปรแบบ SharedPreferences
                                      sharedPreferences.setString('storeID', body['id']);
                                      sharedPreferences.setString('storeFullname', _fullname!);
                                      sharedPreferences.setString('storeUsername', _username!);
                                      sharedPreferences.setString('storeImgProfile', "noimg.jpg");

                                      // เก็บค่า step การ login
                                      sharedPreferences.setInt('storeStep', 1);

                                      // ส่งไปหน้า dashboard
                                      Navigator.pushReplacementNamed(context, '/dashboard');

                                    }else{
                                      Utility().showAlertDialog(context, 'มีข้อผิดพลาด', 'ไม่สามารถลงทะเบียนได้');
                                    }

                                  }

                                },
                                child: Padding(
                                  // padding: const EdgeInsets.only(left: 20, right: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 10),
                                  child: Text(
                                    'ลงทะเบียน',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'ถ้าเป็นสมาชิกอยู่แล้ว ?',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/login');
                                },
                                child: Text(
                                  'เข้าสู่ระบบ',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}