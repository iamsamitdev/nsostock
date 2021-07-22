import 'package:flutter/material.dart'; // fim

// statefulW
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // fscaff
      body: Center(child: Text('Home'),),
    );
  }
}