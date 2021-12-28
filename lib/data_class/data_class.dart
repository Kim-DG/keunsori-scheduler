import 'package:flutter/material.dart';

class Schedule {
  int concertId;
  String date;
  String content;

  Schedule(this.concertId, this.date, this.content);
}

class ApiSchedule {
  int id;
  Schedule schedule;

  ApiSchedule( this.id, this.schedule);
}

class Concert {
  String date;
  String concertName;

  Concert(this.date, this.concertName);
}

class ApiConcert {
  int id;
  Concert concert;

  ApiConcert(this.id, this.concert);
}

class SongInfo {
  String singerName;
  String songName;
  String? remarks;
  String? link;
  List<int> difficulty;
  bool score;
  int voteNum = 0;

  SongInfo(
      this.singerName,
      this.songName,
      this.remarks,
      this.link,
      this.difficulty,
      this.score);
}

class ApiSongInfo {
  int id;
  SongInfo songInfo;

  ApiSongInfo(
      this.id,
      this.songInfo);
}


class ConcertId with ChangeNotifier {
  int _id = 0;
  String _content = '';
  late String _date;

  int get id => _id;

  String get content => _content;

  String get date => _date;

  void set(int id, String content, String date) {
    _id = id;
    _content = content;
    _date = date;
    notifyListeners();
  }

  void add() {
    _id++;
    notifyListeners();
  }

  void remove() {
    _id--;
    notifyListeners();
  }
}
