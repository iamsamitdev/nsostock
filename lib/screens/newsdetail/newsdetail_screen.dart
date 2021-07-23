import 'package:flutter/material.dart';
import 'package:nsostock/models/NewsDetailModel.dart';
import 'package:nsostock/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  NewsDetailScreen({Key? key}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

   // เรียกใช้งาน Model
  NewsDetailModel? _dataNews;

  // สร้งฟังก์ชันอ่านรายละเอียดข่าว
  readNewsDetail(id) async {
    try{
      var response = await CallAPI().getNewsByID(id);

      setState(() {
        _dataNews = response;
      });

    }catch(error){
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance;

    widgetsBinding!.addPostFrameCallback((callback) {
      // การรับค่าจาก arguments
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
        // เรียกฟังก์ชัน readNewsDetail
        readNewsDetail(arguments['id'].toString());
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_dataNews?.topic ?? "..."}'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_dataNews?.imageurl ?? "..."),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${_dataNews?.topic ?? "..."}', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${_dataNews?.detail ?? "..."}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Published: ${_dataNews?.createdAt ?? "..."}'),
          )
        ],
      ),
    );
  }
}