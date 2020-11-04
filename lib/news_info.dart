import 'package:flutter/material.dart';
import 'package:news/models/news_detail.dart';

class NewsInfo extends StatelessWidget {
  final NewsDetail newsDetail;

  NewsInfo(this.newsDetail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(newsDetail.title, style: TextStyle(fontSize: 20)),
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
        body: Container(
            child: Card(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _renderBody(context, newsDetail),
              )),
        )));
  }

  List<Widget> _renderBody(BuildContext context, NewsDetail newsDetail) {
    var result = List<Widget>();
    result.add(_bannerImage(newsDetail.url, 200.0));
    result.addAll(_renderInfo(context, newsDetail));
    return result;
  }

  List<Widget> _renderInfo(BuildContext context, NewsDetail newsDetail) {
    var result = List<Widget>();
    result.add(_sectionTitle(newsDetail.title));
    result.add(_sectionText(newsDetail.description));
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }

  Widget _sectionText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
      child: Text(text,
          textAlign: TextAlign.start, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _bannerImage(String url, double height) {
    return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: Image.network(url, fit: BoxFit.fitWidth));
  }
}
