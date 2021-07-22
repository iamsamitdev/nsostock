import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nsostock/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้างตัวแปรไว้เก็บ username และ password
  String? _username, _password;

  // สร้างตัวแปร key ไว้ผูกกับแบบฟอร์ม
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.fill
            )
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', width: 100, height: 100,),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, size: 28,),
                                  labelText: 'ชื่อผู้ใช้',
                                  hintText: 'กรุณป้อนชื่อผู้ใช้',
                                  hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                                  errorStyle: TextStyle(fontSize: 18, color: Colors.red),
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
                                style: TextStyle(fontSize: 24, color: Colors.teal),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock, size: 28,),
                                  labelText: 'รหัสผ่าน',
                                  hintText: 'กรุณป้อนรหัสผ่าน',
                                  hintStyle: TextStyle(fontSize: 18, color: Colors.black),
                                  errorStyle: TextStyle(fontSize: 18, color: Colors.red),
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
                              SizedBox(height: 24,),
                              ElevatedButton(
                                onPressed: () async {

                                  if(formKey.currentState!.validate()){
                                    formKey.currentState!.save();
                                  }

                                  // print(_username! + _password!);

                                  // เรียกใช้ LoginAPI
                                  var response = await CallAPI().loginAPI(
                                    {
                                      "username": _username,
                                      "password": _password
                                    }
                                  );

                                  var body = json.decode(response.body);

                                  print(body);
                                  if(body['status'] == 'success'){

                                    // สร้าง Object แบบ SharedPreferences
                                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                                    // เก็บค่าที่ต้องการลงในตัวแปรแบบ SharedPreferences
                                    sharedPreferences.setString('storeID', body['data']['id']);
                                    sharedPreferences.setString('storeFullname', body['data']['fullname']);
                                    sharedPreferences.setString('storeUsername', body['data']['username']);
                                    sharedPreferences.setString('storeImgProfile', body['data']['img_profile']);

                                    // ส่งไปหน้า dashboard
                                    Navigator.pushReplacementNamed(context, '/dashboard');
                                  }else{
                                    print('Login fail!');
                                  }
                                  
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(color: Colors.white, fontSize: 24),
                                  ),
                                )  
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'ยังไม่เป็นสมาชิก ?',
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                   Navigator.pushReplacementNamed(context, '/register');
                                },
                                child: Text(
                                  'สมัครสมาชิก',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ),
                      )
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