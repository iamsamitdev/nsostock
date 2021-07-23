import 'package:flutter/material.dart'; // fim
import 'package:nsostock/models/NewsModel.dart';
import 'package:nsostock/services/rest_api.dart';
import 'package:nsostock/utils/constants.dart';

// statefulW
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              text_hot_news,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 210.0,
            child: FutureBuilder(
              future: CallAPI().getLastNews(),
              builder: (BuildContext context, AsyncSnapshot<List<NewsModel>?> snapshot){
                // กรณีที่มีข้อผิดพลาด
                if(snapshot.hasError){
                  return Container(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),);
                // ถ้าโหลดข้อมูลเสร็จแล้ว
                }else if(snapshot.connectionState == ConnectionState.done){
                  List<NewsModel>? news = snapshot.data;
                  return _listViewLastNews(news!);
                // ถ้ากำลังโหลดข้อมูลอยู่
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              text_general_news,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
                future: CallAPI().getAllNews(),
                builder: (BuildContext context, AsyncSnapshot<List<NewsModel>?> snapshot){    
                // กรณีที่มีข้อผิดพลาด
                if(snapshot.hasError){
                  return Container(child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),);
                // ถ้าโหลดข้อมูลสำเร็จ
                }else if(snapshot.connectionState == ConnectionState.done){
                  List<NewsModel>? news = snapshot.data;
                  return _listViewAllNews(news!);
                // ถ้ากำลังโหลดข้อมูลอยู่
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),
          )
        ],
      ),
    );
  }

  // -------------------------------------------
  // สร้าง ListView สำหรับการแสดงข่าวล่าสุด
  // -------------------------------------------
  Widget _listViewLastNews(List<NewsModel> news){
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: news.length,
      itemBuilder: (context, index){
        
        // Load Model
        NewsModel newsModel = news[index];

        return Container(
          width: MediaQuery.of(context).size.width * 0.60,
          child: InkWell(
            onTap: (){

            },
            child: Card(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 125.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(newsModel.imageurl.toString()),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            newsModel.topic.toString(),
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            newsModel.detail.toString(),
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );

      }
    );
  }

  // ------------------------------------------
  // สร้าง ListView สำหรับการแสดงข่าวทั้งหมด
  // ------------------------------------------
  Widget _listViewAllNews(List<NewsModel> news) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: news.length,
        itemBuilder: (context, index) {
          // Load Model
          NewsModel newsModel = news[index];

          return ListTile(
            leading: Icon(Icons.pages),
            title: Text(
              newsModel.topic.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              newsModel.detail.toString(),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (){

            },
          );
        },
      ),
    );
  }



}