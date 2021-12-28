import 'package:flutter/material.dart';
import 'package:keunsori/format/button.dart';
import 'package:keunsori/format/text.dart';
import 'package:keunsori/concert_choice/concert_choice.dart';
import 'package:keunsori/song_selection/song_selection.dart';
import 'package:keunsori/song_sequence.dart';
import 'package:keunsori/voting.dart';
import 'package:keunsori/practice_schedule/practice_schedule.dart';
import 'package:keunsori/data_class/data_class.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState(){

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
                              builder: (context) => (ConcertChoice())));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (SongSelection())));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (PracticeSchedule())));
                      })),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: TextButtonFormat(
                      text: '투표',
                      letterSpacing: 10.0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (Voting())));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (SongSequence())));
                      })),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
          Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
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
