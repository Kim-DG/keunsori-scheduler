import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Concert {
  final String date;
  final String concertName;

  Concert(this.date, this.concertName);

  Map<String, dynamic> toJson() => {
    'date' : date,
    'concertName' : concertName,
  };
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

class ResultGet{
  final int code;
  final String message;
  final List<dynamic> result;

  ResultGet(this.code, this.message, this.result);

  ResultGet.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        result = json['result'];
}

class ResultGetFind{
  final int code;
  final String message;
  final dynamic result;

  ResultGetFind(this.code, this.message, this.result);

  ResultGetFind.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        result = json['result'];
}

class ResultPost{
  final int code;
  final String message;
  final int result;

  ResultPost(this.code, this.message, this.result);

  ResultPost.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        result = json['result'];
}

class Result{
  final int code;
  final String message;
  final bool result;

  Result(this.code, this.message, this.result);

  Result.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        result = json['result'];
}

class Schedule {
  final int concertId;
  final String date;
  final String content;

  Schedule(this.concertId, this.date, this.content);

  Map<String, dynamic> toJson() => {
    'concertId' : concertId,
    'date' : date,
    'content' : content
  };
}

class ApiSchedule {
  final int id;
  final int concertId;
  final String date;
  final String content;

  ApiSchedule( this.id, this.concertId, this.date, this.content);

  ApiSchedule.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        concertId = json['concertId'],
        date = json['date'],
        content = json['content'];
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

  Map<String, dynamic> toJson() => {
    'concertId' : concertId,
    'selectorName' : selectorName,
    'singerName' : singerName,
    'songName' : songName,
    'remarks' : remarks,
    'link' : link,
    'difficulty' : difficulty,
    'score' : score
  };
}

class ApiSongInfo {
  final int id;
  final int concertId;
  final String selectorName;
  final String singerName;
  final String songName;
  final String? remarks;
  final String? link;
  final List<dynamic> difficulty;
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

  ApiSongInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        concertId = json['concertId'],
        selectorName = json['selectorName'],
        singerName = json['singerName'],
        songName = json['songName'],
        remarks = json['remarks'],
        link = json['link'],
        difficulty = json['difficulty'],
        score = json['score'];
}


class SelectedSongInfo{
  final int concertId;
  final String selectorName;
  final String singerName;
  final String songName;

  SelectedSongInfo(this.concertId, this.selectorName, this.singerName, this.songName);

  Map<String, dynamic> toJson() => {
    'concertId' : concertId,
    'selectorName' : selectorName,
    'singerName' : singerName,
    'songName' : songName
  };
}

class ApiSelectedSongInfo{
  final int id;
  final int concertId;
  final String selectorName;
  final String singerName;
  final String songName;

  ApiSelectedSongInfo(this.id, this.concertId, this.selectorName, this.singerName, this.songName);

  ApiSelectedSongInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        concertId = json['concertId'],
        selectorName = json['selectorName'],
        singerName = json['singerName'],
        songName = json['songName'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'concertId' : concertId,
    'selectorName' : selectorName,
    'singerName' : singerName,
    'songName' : songName
  };
}

class SelectedSongList{
  final List<ApiSelectedSongInfo> listSelectedSongInfo;

  SelectedSongList(this.listSelectedSongInfo);

  Map<String, dynamic> toJson() => {
    'listSelectedSongInfo' : listSelectedSongInfo
  };
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
