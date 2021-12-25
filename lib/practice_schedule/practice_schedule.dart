import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/format/text.dart';
import 'package:keunsori/data_class/data_class.dart';

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
  DateTime selectedDate = DateTime.now(); // TO tracking date
  DateTime start = DateTime(
    2022,
    1,
    1,
  );
  int currentDateSelectedIndex = 0; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //To Track Scroll of ListView

  Schedule ex = Schedule("2022-01-02", "asfasf");

  final textEditController = TextEditingController();
  String addContent = '';
  String tapDate = '';
  Schedule addSchedule = Schedule('date', 'content');

  List<Schedule> listSchedule = [];
  List<Schedule> filterSchedule = [];

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


  void addDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Opacity(
            opacity: 0.7,
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
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
                image: AssetImage('assets/textfield.png'),
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
                          addContent = text;
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
                    addSchedule = Schedule(tapDate, addContent);
                    listSchedule.add(addSchedule);
                    filterSchedule = listSchedule
                        .where((element) => element.date == tapDate)
                        .toList();
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
  void initState() {
    super.initState();
    listSchedule.add(ex);
    tapDate = start.toString().split(' ')[0];
  }

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
                            .where((element) => element.date == tapDate)
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
                                              .month -
                                          1]
                                      .toString() +
                                  start
                                      .add(Duration(days: index))
                                      .day
                                      .toString() +
                                  "日",
                              color: currentDateSelectedIndex == index
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 14,
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
          Flexible(
              fit: FlexFit.tight,
              child: Stack(children: [
                Opacity(
                  opacity: 0.7,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: filterSchedule.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (detail) {
                          if(detail.primaryDelta! > 7.0) {
                            print(detail.primaryDelta);
                            if(filterSchedule.isNotEmpty) {
                              Schedule deleteSchedule = filterSchedule[index];
                              setState(() {
                                listSchedule.removeWhere((element) =>
                                element == deleteSchedule);
                                filterSchedule.removeWhere((
                                    element) => element == deleteSchedule);
                              });
                            }
                          }
                        },
                        child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          child: TextFormat(
                            text: filterSchedule[index].content,
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
                        addDialog();
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
          const SizedBox(
            height: 20,
          ),
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

