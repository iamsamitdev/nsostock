import 'package:flutter/material.dart';
import 'package:nsostock/screens/bottomnavmenu/account/account_screen.dart';
import 'package:nsostock/screens/bottomnavmenu/home/home_screen.dart';
import 'package:nsostock/screens/bottomnavmenu/notification/notification_screen.dart';
import 'package:nsostock/screens/bottomnavmenu/report/report_screen.dart';
import 'package:nsostock/screens/bottomnavmenu/setting/setting_screen.dart';
import 'package:nsostock/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart'; // fim

// statefulW
class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้างตัวแปรไว้เก็บ fullname, username  และ imgProfile
  String? _fullname, _username, _imgProfile;

  // สร้าง Object แบบ Sharedpreferences
  SharedPreferences? sharedPreferences;

  // สร้างฟังก์ชันสำหรับดึงข้อมูล user
  getProfile() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _fullname = sharedPreferences!.getString('storeFullname');
      _username = sharedPreferences!.getString('storeUsername');
      _imgProfile = sharedPreferences!.getString('storeImgProfile');
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

  // สร้างตัวแปรไว้เก็บ list รายการของ tab bottomNavigation และ App Bar
  int _currentIndex = 0;
  String _title = app_name;

  // สร้าง List เก็บรายการ Screen
  List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    AccountScreen()
  ];

  // เขียนเงื่อนไขการเปลี่ยน tab
  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
      switch(index){
        case 0:
          _title = dashboard_title;
          break;
        case 1:
          _title = report_title;
          break;
        case 2:
          _title = notification_title;
          break;
        case 3:
          _title = setting_title;
          break;
        case 4:
          _title = account_title;
          break;
      }
    });
  }

  @override
  void initState() { 
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // fscaff
      appBar: AppBar(
        title: Text('$_title'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: dashboard_title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: report_title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: notification_title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: setting_title
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: account_title
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('$_fullname'), 
              accountEmail: Text('$_username'),
              currentAccountPicture: _imgProfile != null ? CircleAvatar(
                backgroundImage:  NetworkImage('http://localhost:8080/nso_flutter_api/public/images/profile/$_imgProfile')
              ) : CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(about_menu_text),
              onTap: (){
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.book_online),
              title: Text(term_menu_text),
              onTap: (){
                Navigator.pushNamed(context, '/termpolicy');
              },
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(contact_menu_text),
              onTap: (){
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(signout_menu_text),
              onTap: logout,
            )
          ],
        ),
      ),
    );
  }
}