import 'package:flutter/material.dart';
import 'package:nsostock/models/UserModel.dart';
import 'package:nsostock/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  // สร้างตัวแปรไว้เก็บ ชื่อและรูปโปรไฟล์
  String? _fullname, _username, _avatar;

  SharedPreferences? sharedPreferences;

  // เรียกใช้งาน Model UserModel
  UserModel? userModel;

  // สร้างฟังก์ชันในการอ่านข้อมูลผู้ใช้
  readUserProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var response = await CallAPI().getProfile(sharedPreferences!.getString('storeID'));
    setState(() {
      userModel = response;
      _fullname = userModel!.fullname;
      _username = userModel!.username;
      _avatar = userModel!.imgProfile;
    });
  }

  // สร้างฟังก์ชันสำหรับ logout
  logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      // sharedPreferences!.clear();
      sharedPreferences!.setInt('storeStep', 2);
    });
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() { 
    super.initState();
    readUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
               image: DecorationImage(
                 image: AssetImage('assets/images/bg_acc.jpg'),
                 fit: BoxFit.cover
               )
             ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.white,
                    child:_avatar != null ? CircleAvatar(
                      radius: 46.0,
                      // backgroundImage: AssetImage('assets/images/samit_profile.jpg'),
                      backgroundImage: NetworkImage(
                        'http://localhost:8080/nso_flutter_api/public/images/profile/$_avatar'
                      ),
                    ): CircularProgressIndicator(),
                  ),
                ),
                Text('${_fullname ?? "..." }', style: TextStyle(color: Colors.white, fontSize: 24),),
                Text('${_username ?? "..." }', style: TextStyle(color: Colors.white, fontSize: 16),),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ข้อมูลผู้ใช้'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('เปลี่ยนรหัสผ่าน'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('เปลี่ยนภาษา'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ติดต่อทีมงาน'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('ตั้งค่าใช้งาน'),
            trailing: Icon(Icons.navigate_next),
            onTap: (){},
          ),
           ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('ออกจากระบบ'),
            trailing: Icon(Icons.navigate_next),
            onTap: logout,
          )
        ],
      ),
    );
  }
}