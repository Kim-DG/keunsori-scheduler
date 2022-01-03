import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:keunsori/format/button.dart';
import 'package:keunsori/format/text.dart';
import 'package:keunsori/concert_choice/concert_choice.dart';
import 'package:keunsori/song_selection/song_selection.dart';
import 'package:keunsori/song_sequence/song_sequence.dart';
import 'package:keunsori/practice_schedule/practice_schedule.dart';
import 'package:keunsori/data_class/data_class.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConcertId()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '큰소리 공연',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late Future<ResultGet> resultConcert;
  late ApiConcert firstConcert;

  Future<ResultGet> getConcert() async{
    final response = await http
        .get(Uri.parse('http://10.0.3.2:3000/concerts'));
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

  @override
  void initState(){
    super.initState();
    resultConcert = getConcert();
    resultConcert.then((data){
      if(data.result.isNotEmpty) {
        firstConcert = ApiConcert.fromJson(data.result[data.result.length-1]);
        context.read<ConcertId>().set(firstConcert.id, firstConcert.concertName, firstConcert.date);
      }
    });
  }

  void problemDialog() {
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
                            text: '공연을 선택해 주세요!',
                            letterSpacing: 2.0,
                            fontSize: 18.0,
                            color: Colors.black87,
                            height: 1.5,
                          ))
                    ],
                  ),
                )),
          );
        });
  }

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
          SizedBox(
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 50.0,
                  ),
                  TextFormat(text: '큰소리'),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormat(text: '공연 매니저', wordSpacing: -15.0)
                ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: TextButtonFormat(
                    text: '공연선택',
                    letterSpacing: 2.0,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (const ConcertChoice())));
                    },
                  )),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: TextButtonFormat(
                      text: '선곡',
                      letterSpacing: 10.0,
                      onPressed: () {
                        if(context.read<ConcertId>().id == 0){
                          problemDialog();
                        }
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (const SongSelection())));
                        }
                      })),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: TextButtonFormat(
                      text: '연습일정',
                      letterSpacing: 2.0,
                      onPressed: () {
                        if(context.read<ConcertId>().id == 0){
                          problemDialog();
                        }
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (
                                      context) => (const PracticeSchedule())));
                        }
                      })),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: TextButtonFormat(
                      text: '곡순서',
                      letterSpacing: 10.0,
                      onPressed: () {
                        if(context.read<ConcertId>().id == 0){
                          problemDialog();
                        }
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (
                                      context) => (const SongSequence())));
                        }
                      })),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
          Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(20.0),
              child: TextFormat(
                text: context.watch<ConcertId>().content,
                color: Colors.white70,
                fontSize: 20.0,
                letterSpacing: 2.0,
              ))
        ],
      ),
    );
  }
}
