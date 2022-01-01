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
  ScrollController scrollController = ScrollController();
  final textEditController = TextEditingController();
  late DateTime selectedDate;
  String date = DateTime.now().toString().split(' ')[0];
  String addConcert = '';

  List<ApiConcert> listConcert = [];

  @override
  void initState() {
    super.initState();


    ApiConcert ex = ApiConcert(1,date,"fff");
    ApiConcert ex2 = ApiConcert(2,date,"ddd");
    listConcert.add(ex);
    listConcert.add(ex2);
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
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    listConcert.removeWhere((element) =>
                                    element == concert);
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
                      addConcert = text;
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
                listConcert.add(ApiConcert(5,date,addConcert));
                print(listConcert[0].date);
                textEditController.text = '';
                return Navigator.of(context).pop();
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
          body: Stack(children: [
              Opacity(
                opacity: 0.7,
                child: ListView.builder(
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
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(bottom: 5.0),
                child: Opacity(
                  opacity: 0.7,
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
              ),
            ]),
          ),
    );
  }
}
