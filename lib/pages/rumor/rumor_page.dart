import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/api/entries_view_model.dart';
import 'package:flutternews/api/rumor_view_model.dart';
import 'package:flutternews/api/statistics_model.dart';
import 'package:flutternews/api/statistics_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RumorPage extends StatefulWidget {
  @override
  _RumorPageState createState() => _RumorPageState();
}

class _RumorPageState extends State<RumorPage>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> data = new List();
  bool isReq = false;
  List entriesData = new List();

  StatisticsModel statisticsModel = new StatisticsModel();

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: new Center(
        child: new Text('${data}'),
      ),
    );
  }

//涛涛的接口
//  getData() async {
//    Dio dio = new Dio();
//    Response response = await dio.get("http://119.45.34.76:8080/greet/hello");
//    print("cyc----response:$response");
//    setState(() {
//      data = response.toString();
//    });
//  }

  getData() {
    rumorListReqViewModel.getRumor().then((v) {
      //谣言列表
      setState(() {
        data = v;
        isReq = true;
      });
    });
    //统计数据
    statisticsViewModel.getData().then((v) {
      setState(() {
        statisticsModel = v;
      });
    });
    //诊疗信息
    entriesViewModel.getData().then((value) {
      setState(() {
        entriesData = value;
      });
    });


  }
}
