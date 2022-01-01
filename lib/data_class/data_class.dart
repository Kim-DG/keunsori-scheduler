import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Concert {
  final String date;
  final String concertName;

  Concert(this.date, this.concertName);
}

class ApiConcert {
  final int id;
  final String date;
  final String concertName;

  ApiConcert(this.id, this.date, this.concertName);

  ApiConcert.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        concertName = json['concertName'];
}

class ResultConcert{
  final int code;
  final String message;
  final List<dynamic> result;

  ResultConcert(this.code, this.message, this.result);

  ResultConcert.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        result = json['result'];
}

class Schedule {
  final int concertId;
  final String date;
  final String content;

  Schedule(this.concertId, this.date, this.content);
}

class ApiSchedule {
  final int id;
  final int concertId;
  final String date;
  final String content;

  ApiSchedule( this.id, this.concertId, this.date, this.content);
}

class SongInfo {
  final int concertId;
  final String selectorName;
  final String singerName;
  final String songName;
  final String? remarks;
  final String? link;
  final List<int> difficulty;
  final bool score;

  SongInfo(
      this.concertId,
      this.selectorName,
      this.singerName,
      this.songName,
      this.remarks,
      this.link,
      this.difficulty,
      this.score);
}

class ApiSongInfo {
  final int id;
  final int concertId;
  final String selectorName;
  final String singerName;
  final String songName;
  final String? remarks;
  final String? link;
  final List<int> difficulty;
  final bool score;

  ApiSongInfo(
      this.id,
      this.concertId,
      this.selectorName,
      this.singerName,
      this.songName,
      this.remarks,
      this.link,
      this.difficulty,
      this.score);
}

class SelectedSongInfo{
  final int concertId;
  final int sequence;
  final String selectorName;
  final String singerName;
  final String songName;

  SelectedSongInfo(this.concertId, this.sequence, this.selectorName, this.singerName, this.songName);
}

class ApiSelectedSongInfo{
  final int id;
  final int concertId;
  final int sequence;
  final String selectorName;
  final String singerName;
  final String songName;

  ApiSelectedSongInfo(this.id, this.concertId, this.sequence, this.selectorName, this.singerName, this.songName);
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
}
