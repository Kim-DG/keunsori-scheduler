import 'package:flutter/material.dart';

class Schedule {
  String date;
  String content;

  Schedule(this.date, this.content);
}

class ApiSchedule{
  late int id;
  late String date;
  late String content;

  ApiSchedule(this.date, this.content);
}

class Concert {
  String content;
  DateTime dateTime;
  Concert(this.content, this.dateTime);
}

class ApiConcert {
  int id;
  String content;
  DateTime dateTime;

  ApiConcert(this.id, this.content, this.dateTime);
}
