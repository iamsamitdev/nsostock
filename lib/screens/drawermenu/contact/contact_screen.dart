import 'package:flutter/material.dart';
import 'package:nsostock/utils/constants.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact_menu_text),
      ),
      body: Center(
        child: Text('รายละเอียด'+contact_menu_text),
      ),
    );
  }
}