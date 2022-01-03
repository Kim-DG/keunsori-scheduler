import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/format/text.dart';
import 'package:keunsori/data_class/data_class.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class PracticeSchedule extends StatelessWidget {
  const PracticeSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image(
                image: AssetImage('assets/bg.gif'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const Opacity(
                        opacity: 0.7,
                        child: Image(
                          image: AssetImage('assets/uppage.png'),
                          fit: BoxFit.fill,
                          width: double.maxFinite,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          alignment: Alignment.center,
                          child: const TextFormat(
                            text: '연습일정',
                            color: Colors.black87,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: const [
                      Opacity(
                          opacity: 0.7,
                          child: Image(
                            width: double.infinity,
                            image: AssetImage('assets/downpage.png'),
                            fit: BoxFit.fill,
                          )),
                      Positioned(
                          bottom: 10,
                          top: 10,
                          left: 10,
                          right: 10,
                          child: Calendar()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}






class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final DateTime start;
  final ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView
  final textEditController = TextEditingController();
  late int concertId;
  late Future<ResultGet> resultSchedule;

  String tapDate = '';
  int currentDateSelectedIndex = 0; //For Ho
  List<ApiSchedule> listSchedule = [];
  List<ApiSchedule> filterSchedule = [];

  List<String> listOfMonths = [
    "1月",
    "2月",
    "3月",
    "4月",
    "5月",
    "6月",
    "7月",
    "8月",
    "9月",
    "10月",
    "11月",
    "12月"
  ];
  List<String> listOfDays = ["月", "火", "水", "木", "金", "土", "日"];

  Future<ResultGet> _getSchedule(int concertId) async{
    String url = 'https://keunsori-scheduler.herokuapp.com/schedules/$concertId';
    final response = await http
        .get(Uri.parse(url));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return ResultGet.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load concert');
    }
  }

  Future<ResultPost> _postSchedule(Schedule schedule) async{
    String url = 'https://keunsori-scheduler.herokuapp.com/schedules';
    String json = jsonEncode(schedule);
    http.Response response = await http.post(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: json);
    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return ResultPost.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load concert');
    }
  }

  Future<Result>_deleteSchedule(int id) async{
    String url = 'https://keunsori-scheduler.herokuapp.com/schedules/$id';
    http.Response response = await http.delete(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Result.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load concert');
    }
  }

  @override
  void initState() {
    super.initState();
    List<String> listDate = context.read<ConcertId>().date.split('-');
    start = DateTime(int.parse(listDate[0]),int.parse(listDate[1]),int.parse(listDate[2]));
    tapDate = start.toString().split(' ')[0];
    concertId = context.read<ConcertId>().id;
    resultSchedule = _getSchedule(concertId);
    resultSchedule.then((data){
      if(data.result.isNotEmpty) {
        for (var element in data.result) {
          listSchedule.add(ApiSchedule.fromJson(element));
        }
      }
    });
  }

  void deleteDialog(ApiSchedule schedule) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Opacity(
            opacity: 0.7,
            child: Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/short_dialog.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop();
                          },
                          child: const Image(
                            image: AssetImage('assets/exit.png'),
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: const TextFormat(
                            text: '삭제하시겠습니까?',
                            letterSpacing: 2.0,
                            fontSize: 20.0,
                            color: Colors.black87,
                            height: 1.5,
                          )),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _deleteSchedule(schedule.id);
                                    listSchedule.removeWhere((element) =>
                                    element == schedule);
                                    filterSchedule.removeWhere((
                                        element) => element == schedule);
                                    return Navigator.of(context).pop();
                                  });
                                },
                                child: const TextFormat(
                                  text: '네',
                                  color: Colors.black87,
                                  fontSize: 12.0,
                                )),
                            TextButton(
                                onPressed: () {
                                  return Navigator.of(context).pop();
                                },
                                child: const TextFormat(
                                  text: '아니오',
                                  color: Colors.black87,
                                  letterSpacing: 2.0,
                                  fontSize: 12.0,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  void addScheduleDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Opacity(
            opacity: 0.7,
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: _buildChild(context),
            ),
          );
        });
  }

  _buildChild(BuildContext context) => Container(
        height: 350,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/dialog.png'), fit: BoxFit.fill)),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  return Navigator.of(context).pop();
                },
                child: const Image(
                  image: AssetImage('assets/exit.png'),
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              child: const Image(
                image: AssetImage('assets/text_field.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextField(
                      controller: textEditController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: InputBorder.none,
                      ),
                      autofocus: true,
                      style: const TextStyle(
                          color: Colors.black87, fontSize: 18, fontFamily: 'A'),
                      cursorColor: Colors.black54,
                      onChanged: (text) {
                        setState(() {
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Schedule schedule = Schedule(concertId,tapDate,textEditController.text);
                    Future<ResultPost> result = _postSchedule(schedule);
                    result.then((data){
                      listSchedule.add(ApiSchedule(data.result,concertId, tapDate, textEditController.text));
                      textEditController.text = '';
                      print(listSchedule);
                      filterSchedule = listSchedule
                          .where((element) => element.date == tapDate)
                          .toList();
                      return Navigator.of(context).pop();
                    });
                  });
                },
                child: const Image(
                  image: AssetImage('assets/plus.png'),
                  width: 45,
                  height: 45,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          //To show Calendar Widget
          Container(
              height: 82,
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10);
                },
                itemCount: 90,
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        tapDate = start
                            .add(Duration(days: index))
                            .toString()
                            .split(' ')[0];
                        currentDateSelectedIndex = index;
                        filterSchedule = listSchedule
                            .where((element) => element.date == tapDate && element.concertId == concertId)
                            .toList();
                        print(tapDate);
                        print(filterSchedule);
                      });
                    },
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        height: 80,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                                image: AssetImage('assets/calendar.png')),
                            color: currentDateSelectedIndex == index
                                ? Colors.black
                                : Colors.transparent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormat(
                              text: listOfDays[
                                      start.add(Duration(days: index)).weekday -
                                          1]
                                  .toString(),
                              color: currentDateSelectedIndex == index
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormat(
                              text: listOfMonths[start
                                              .add(Duration(days: index))
                                              .month - 1]
                                      .toString() +
                                  start
                                      .add(Duration(days: index))
                                      .day
                                      .toString() +
                                  "日",
                              color: currentDateSelectedIndex == index
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 12,
                              letterSpacing: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 1,
              child: Opacity(
                opacity: 0.7,
                child: Column(children: [
                  Expanded(
                    flex: 1,
                    child: FutureBuilder(
                      future: resultSchedule,
                      builder: (context, snapshot){
    if(snapshot.hasData){
                      return ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: filterSchedule.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (detail) {
                              if(detail.primaryDelta! > 7.0) {
                                print(detail.primaryDelta);
                                if(filterSchedule.isNotEmpty) {
                                  ApiSchedule deleteSchedule = filterSchedule[index];
                                  deleteDialog(deleteSchedule);
                                }
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: TextFormat(
                                text: filterSchedule[index].content,
                                color: Colors.black87,
                                fontSize: 24.0,
                                letterSpacing: 2,
                              ),
                            ),
                          );
                        },
                      );
    } else if (snapshot.hasError){
      return const TextFormat(
        text: "오류가 발생했습니다!",
        color: Colors.black87,
        fontSize: 15.0,
        letterSpacing: 2,
      );
    }
    return Container();
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: TextButton(
                      onPressed: () {
                        addScheduleDialog();
                      },
                      child: const Image(
                        image: AssetImage('assets/plus.png'),
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                ]),
              )),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    textEditController.dispose();
    super.dispose();
  }
}

