import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/data_class/data_class.dart';
import 'package:keunsori/format/text.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ConcertChoice extends StatelessWidget {
  const ConcertChoice({Key? key}) : super(key: key);


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
                            text: '공연선택',
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
                          child: ConcertList()),
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


class ConcertList extends StatefulWidget {
  const ConcertList({Key? key}) : super(key: key);

  @override
  _ConcertListState createState() => _ConcertListState();
}

class _ConcertListState extends State<ConcertList> {
  final ScrollController scrollController = ScrollController();
  final textEditController = TextEditingController();
  late DateTime selectedDate;
  late String date;

  List<ApiConcert> listConcert = [];

  late Future<ResultGet> resultConcert;

  Future<ResultGet> _getConcert() async{
    String url = 'https://keunsori-scheduler.herokuapp.com/concerts';
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

  Future<ResultPost>_postConcert(Concert concert) async{
    String url = 'http://keunsori-scheduler.herokuapp.com/concerts';
    String json = jsonEncode(concert);
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

  Future<Result>_deleteConcert(int id) async{
    String url = 'https://keunsori-scheduler.herokuapp.com/concerts/$id';
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
    date = DateTime.now().toString().split(' ')[0];
    listConcert.clear();

    resultConcert = _getConcert();
    resultConcert.then((data){
      if(data.result.isNotEmpty) {
        for (var element in data.result) {
          listConcert.insert(0,ApiConcert.fromJson(element));
        }
      }
    });
  }

  void deleteDialog(ApiConcert concert) {
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
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    listConcert.removeWhere((element) =>
                                    element == concert);
                                    _deleteConcert(concert.id);
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

  void addConcertDialog() {
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
        Center(
          child: Padding(
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
                setState(() {});
              },
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
          child: TextButton(
            onPressed: () {
              setState(() {
                Concert concert = Concert(date,textEditController.text);
                Future<ResultPost> result = _postConcert(concert);
                result.then((data){
                  listConcert.insert(0,ApiConcert(data.result, date, textEditController.text));
                  textEditController.text = '';
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
          body: Opacity(
            opacity: 0.7,
            child: Column(children: [
                Expanded(
                  flex: 1,
                  child: FutureBuilder<ResultGet>(
                    future: resultConcert,
                    builder: (context,snapshot) {
                      if(snapshot.hasData){
                      return ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        itemCount: listConcert.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (detail) {
                              if(detail.primaryDelta! > 7.0) {
                                print(detail.primaryDelta);
                                if(listConcert.isNotEmpty) {
                                  ApiConcert deleteConcert = listConcert[index];
                                  deleteDialog(deleteConcert);
                                }
                              }
                            },
                            onTap: (){  // 클릭 시 해당 공연을 선택하여 정보를 볼 수 있음
                              setState(() {
                                context.read<ConcertId>().set(listConcert[index].id, listConcert[index].concertName, listConcert[index].date);
                              });
                              return Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: TextFormat(
                                text: listConcert[index].concertName,
                                color: Colors.black87,
                                fontSize: 30.0,
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
                    }
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: TextButton(
                    onPressed: () {
                      addConcertDialog();
                    },
                    child: const Image(
                      image: AssetImage('assets/plus.png'),
                      width: 45,
                      height: 45,
                    ),
                  ),
                ),
              ]),
          ),
          ),
    );
  }
}
