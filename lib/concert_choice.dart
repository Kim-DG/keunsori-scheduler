import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/data_class/data_class.dart';
import 'package:keunsori/format/text.dart';

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

  List<Concert> listConcert = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
          body: Container(
              child: Stack(children: [
                Opacity(
                  opacity: 0.7,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (detail) {
                          if(detail.primaryDelta! > 7.0) {
                            print(detail.primaryDelta);
                            if(listConcert.isNotEmpty) {
                              Concert deleteSchedule = listConcert[index];
                              setState(() {
                                listConcert.removeWhere((element) =>
                                element == deleteSchedule);
                                listConcert.removeWhere((
                                    element) => element == deleteSchedule);
                              });
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: TextFormat(
                            text: "dd",
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
                  child: Opacity(
                    opacity: 0.7,
                    child: TextButton(
                      onPressed: () {

                      },
                      child: const Image(
                        image: AssetImage('assets/plus.png'),
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                ),
              ])),
    ));
  }
}
