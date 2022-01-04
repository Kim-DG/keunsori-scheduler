import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/format/text.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../data_class/data_class.dart';

class SongSequence extends StatelessWidget {
  const SongSequence({Key? key}) : super(key: key);

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
                          text: '곡순서',
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
                        child: SelectedSongs())
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

class SelectedSongs extends StatefulWidget {
  const SelectedSongs({Key? key}) : super(key: key);

  @override
  _SelectedSongsState createState() => _SelectedSongsState();
}

class _SelectedSongsState extends State<SelectedSongs> {
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  late int concertId;
  late Future<ResultGet> resultSongInfo;

  List<ApiSelectedSongInfo> listSelectedSongInfo = [];

  Future<ResultGet> _getSongInfo() async{
    String url = 'https://keunsori-scheduler.herokuapp.com/selected-songs/$concertId';
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
      throw Exception('Failed to load selected-song');
    }
  }

  Future<Result>_deleteSongInfo(int id) async{
    String url = 'https://keunsori-scheduler.herokuapp.com/selected-songs/$id';
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
      throw Exception('Failed to load selected-song');
    }
  }

  Future<Result>_putSongInfo(int id, Sequence sequence) async{
    String url = 'https://keunsori-scheduler.herokuapp.com/selected-songs/$id';
    String json = jsonEncode(sequence);
    http.Response response = await http.put(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: json);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return Result.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load selected-song');
    }
  }

  @override
  void initState() {
    super.initState();
    concertId = context.read<ConcertId>().id;
    listSelectedSongInfo.clear();
    resultSongInfo = _getSongInfo();
    resultSongInfo.then((data){
      if(data.result.isNotEmpty) {
        for (var element in data.result) {
          listSelectedSongInfo.add(ApiSelectedSongInfo.fromJson(element));
        }
      }
    });
  }

  void deleteDialog(ApiSelectedSongInfo selectedSongInfo) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Opacity(
            opacity: 0.8,
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
                                    _deleteSongInfo(selectedSongInfo.id);
                                    listSelectedSongInfo.removeWhere((element) =>
                                    element == selectedSongInfo);
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

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    listSelectedSongInfo.clear();
    resultSongInfo = _getSongInfo();
    resultSongInfo.then((data){
      if(data.result.isNotEmpty) {
        for (var element in data.result) {
          setState(() {
            listSelectedSongInfo.add(ApiSelectedSongInfo.fromJson(element));
          });
        }
      }
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SmartRefresher(
          header: const ClassicHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Opacity(
            opacity: 0.7,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: FutureBuilder(
                      future: resultSongInfo,
                      builder: (context, snapshot){
                        return ReorderableListView(
                          buildDefaultDragHandles: false,
                          children: <Widget>[
                            for (int index = 0; index < listSelectedSongInfo.length; index++)
                              Container(
                                key: Key('$index'),
                                child: GestureDetector(
                                  onHorizontalDragUpdate: (detail) {
                                    if (detail.primaryDelta! > 7.0) {
                                      print(detail.primaryDelta);
                                      if (listSelectedSongInfo.isNotEmpty) {
                                        ApiSelectedSongInfo deleteSongInfo = listSelectedSongInfo[index];
                                        deleteDialog(deleteSongInfo);
                                      }
                                    }
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 64,
                                        height: 64,
                                        padding: const EdgeInsets.all(8),
                                        child: ReorderableDragStartListener(
                                          index: index,
                                          child: const Image(
                                            image: AssetImage('assets/handle.png'),
                                          ),
                                        ),
                                      ),
                                      TextFormat(
                                        text: listSelectedSongInfo[index].singerName +
                                            " - " +
                                            listSelectedSongInfo[index].songName,
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                        letterSpacing: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                          onReorder: (int oldIndex, int newIndex) {
                            setState(() {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final ApiSelectedSongInfo item = listSelectedSongInfo.removeAt(oldIndex);
                              listSelectedSongInfo.insert(newIndex, item);
                              for(var element in listSelectedSongInfo){
                                element.sequence = listSelectedSongInfo.indexOf(element);
                                Sequence seq = Sequence(element.sequence);
                                _putSongInfo(element.id, seq);
                              }
                            });
                          },
                        );},
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}