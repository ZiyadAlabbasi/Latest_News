import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../news_info.dart';
import 'news_detail.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<NewsScreen> {
  final List<NewsDetail> items = [];

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Center(
            child: Text(
              "Latest News",
              style: TextStyle(fontSize: 22),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Center(
                            child: Text(
                              "Latest News",
                              style: TextStyle(
                                  fontFamily: "Times New Roman",
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Text(
                            "Developer: Ziyad Saeed Mohammed",
                            style: TextStyle(
                              fontFamily: "Time New Roman",
                              fontSize: 18.0,
                            ),
                          ),
                          actions: <Widget>[
                            Material(
                              elevation: 100.0,
                              borderRadius: BorderRadius.circular(100.0),
                              child: Center(
                                child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  child: Center(
                                    child: Image.asset(
                                      "image/goodnews.png",
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                0.0,
                                0.0,
                                25.0,
                                0.0,
                              ),
                              child: Text(
                                "\nContact information to develop your app\n zsm093@gmail.com\n +964(0)7508343364",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Back',
                                style: TextStyle(
                                  fontFamily: "Time New Roman",
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: this.items.length, itemBuilder: _listViewItemBuilder));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var newsDetail = this.items[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
                contentPadding: EdgeInsets.all(5.0),
                leading: _itemThumbnail(newsDetail),
                title: _itemTitle(newsDetail),
                onTap: () {
                  _navigationToNewsDetail(context, newsDetail);
                }),
          ],
        ),
      ),
    );
  }

  void _navigationToNewsDetail(BuildContext context, NewsDetail newsDetail) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewsInfo(newsDetail);
    }));
  }

  Widget _itemThumbnail(NewsDetail newsDetail) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: newsDetail.url == null
          ? null
          : Image.network(newsDetail.url, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(NewsDetail newsDetail) {
    return Text(newsDetail.title);
  }

  void getNews() async {
    final http.Response response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=d2eccaadb59e4fa0b3275a828607f722");
    final Map<String, dynamic> responseData = json.decode(response.body);
    responseData['articles'].forEach((newsDetail) {
      final NewsDetail news = NewsDetail(
          description: newsDetail['description'],
          title: newsDetail['title'],
          url: newsDetail['urlToImage']);
      setState(() {
        items.add(news);
      });
    });
  }
}
