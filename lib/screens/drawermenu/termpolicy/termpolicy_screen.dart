import 'package:flutter/material.dart';
import 'package:nsostock/utils/constants.dart';

class TermPolicy extends StatefulWidget {
  TermPolicy({Key? key}) : super(key: key);

  @override
  _TermPolicyState createState() => _TermPolicyState();
}

class _TermPolicyState extends State<TermPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(term_menu_text),
      ),
      body: Center(
        child: Text('รายละเอียด'+term_menu_text),
      ),
    );
  }
}