import 'package:flutter/material.dart';

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
                              ),
                              SizedBox(height: 24,),
                              ElevatedButton(
                                onPressed: (){},
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