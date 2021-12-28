import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/format/text.dart';

import 'data_class/data_class.dart';

class Voting extends StatelessWidget {
  const Voting({Key? key}) : super(key: key);

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
                          text: '투표',
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
                        child: VoteList()),
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

class VoteList extends StatefulWidget {
  const VoteList({Key? key}) : super(key: key);

  @override
  _VoteListState createState() => _VoteListState();
}

class _VoteListState extends State<VoteList> {
  ScrollController scrollController = ScrollController();
  List<SongInfo> listSongInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
              itemCount: listSongInfo.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){  // 클릭 시 해당 공연을 선택하여 정보를 볼 수 있음
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: TextFormat(
                      text: listSongInfo[index].singerName +
                          " - " +
                          listSongInfo[index].songName,
                      color: Colors.black87,
                      fontSize: 30.0,
                      letterSpacing: 2,
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

