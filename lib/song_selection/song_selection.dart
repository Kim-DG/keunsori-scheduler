import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/data_class/data_class.dart';
import 'package:keunsori/format/text.dart';

class SongSelection extends StatelessWidget {
  const SongSelection({Key? key}) : super(key: key);

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
                          text: '선곡',
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
                        child: AddSong()),
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

class AddSong extends StatefulWidget {
  const AddSong({Key? key}) : super(key: key);

  @override
  _AddSongState createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  ScrollController scrollController = ScrollController();
  final songNameTextEditController = TextEditingController();
  final singerNameTextEditController = TextEditingController();
  final remarksTextEditController = TextEditingController();
  final linkTextEditController = TextEditingController();

  //api로 변경예정
  List<SongInfo> listSongInfo = [];
  List<int> listDifficulty = [0,0,0,0,0,0,0,0,0];

  Map mapDifficulty = {
    'EG1': 0,
    'EG2': 1,
    'AG1': 2,
    'AG2': 3,
    'Bass': 4,
    'Drum': 5,
    'K1': 6,
    'K2': 7,
    'K3': 8,
  };

  List<String> textDifficulty = ['X', '하', '중하', '중', '중상', '상'];

  bool? _checkBoxValueScore = false;

  initTextEdit(){
    singerNameTextEditController.text = '';
    songNameTextEditController.text = '';
    remarksTextEditController.text = '';
    linkTextEditController.text = '';
  }

  void infoDialog(SongInfo songInfo, int index) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setDialogState){
            return Opacity(
              opacity: 0.9,
              child: Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/big_dialog.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            return Navigator.of(context).pop(initTextEdit());
                          },
                          child: const Image(
                            image: AssetImage('assets/exit.png'),
                            width: 45,
                            height: 45,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: const Image(
                                image: AssetImage('assets/text_field.png'),
                                fit: BoxFit.fitHeight),
                          ),
                          Positioned(
                            bottom: 12,
                            top: 10,
                            left: 40,
                            right: 40,
                            child: TextField(
                              controller: singerNameTextEditController,
                              decoration: InputDecoration(
                                hintText: songInfo.singerName,
                                border: InputBorder.none,
                                enabledBorder: const UnderlineInputBorder(
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
                                  songInfo.singerName = singerNameTextEditController.text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: const Image(
                                image: AssetImage('assets/text_field.png'),
                                fit: BoxFit.fitHeight),
                          ),
                          Positioned(
                            bottom: 12,
                            top: 10,
                            left: 40,
                            right: 40,
                            child: TextField(
                              controller: songNameTextEditController,
                              decoration: InputDecoration(
                                hintText: songInfo.songName,
                                border: InputBorder.none,
                                enabledBorder: const UnderlineInputBorder(
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
                                  songInfo.songName = songNameTextEditController.text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const TextFormat(
                                text: 'EG1',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['EG1']] == 5) {
                                            songInfo.difficulty[mapDifficulty['EG1']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['EG1']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['EG1']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'EG2',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['EG2']] == 5) {
                                            songInfo.difficulty[mapDifficulty['EG2']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['EG2']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['EG2']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'AG1',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['AG1']] == 5) {
                                            songInfo.difficulty[mapDifficulty['AG1']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['AG1']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['AG1']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'AG2',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['AG2']] == 5) {
                                            songInfo.difficulty[mapDifficulty['AG2']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['AG2']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['AG2']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'B',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['Bass']] == 5) {
                                            songInfo.difficulty[mapDifficulty['Bass']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['Bass']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['Bass']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const TextFormat(
                                text: 'D',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['Drum']] == 5) {
                                            songInfo.difficulty[mapDifficulty['Drum']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['Drum']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['Drum']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'K1',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['K1']] == 5) {
                                            songInfo.difficulty[mapDifficulty['K1']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['K1']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['K1']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'K2',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['K2']] == 5) {
                                            songInfo.difficulty[mapDifficulty['K2']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['K2']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['K2']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: 'K3',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        setDialogState(() {
                                          if (songInfo.difficulty[mapDifficulty['K3']] == 5) {
                                            songInfo.difficulty[mapDifficulty['K3']] = 0;
                                          } else {
                                            songInfo.difficulty[mapDifficulty['K3']]++;
                                          }
                                        });
                                      },
                                      child: TextFormat(
                                        text: textDifficulty[songInfo.difficulty[mapDifficulty['K3']]],
                                        fontSize: 12.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              const TextFormat(
                                text: '악보',
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                color: Colors.black87,
                              ),
                              Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  activeColor: Colors.white,
                                  checkColor: Colors.grey,
                                  value: songInfo.score,
                                  onChanged: (value) {
                                    setDialogState(() {
                                      songInfo.score = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: const Image(
                                image: AssetImage('assets/text_field.png'),
                                fit: BoxFit.fitHeight),
                          ),
                          Positioned(
                            bottom: 12,
                            top: 10,
                            left: 40,
                            right: 40,
                            child: TextField(
                              controller: remarksTextEditController,
                              decoration: InputDecoration(
                                hintText: songInfo.remarks,
                                border: InputBorder.none,
                                enabledBorder: const UnderlineInputBorder(
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
                                  songInfo.remarks = remarksTextEditController.text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: const Image(
                                image: AssetImage('assets/text_field.png'),
                                fit: BoxFit.fitHeight),
                          ),
                          Positioned(
                            bottom: 12,
                            top: 10,
                            left: 40,
                            right: 40,
                            child: TextField(
                              controller: linkTextEditController,
                              decoration: InputDecoration(
                                hintText: songInfo.link,
                                border: InputBorder.none,
                                enabledBorder: const UnderlineInputBorder(
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
                                  songInfo.link = linkTextEditController.text;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                                listSongInfo[index] = songInfo;
                                //api song info
                                return Navigator.of(context).pop(initTextEdit());
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
                ),
              ),
            );}
          );
        });
  }

  void deleteDialog(SongInfo songInfo) {
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
                        padding: const EdgeInsets.only(left: 15.0),
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
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    // api delete song info
                                    listSongInfo.removeWhere(
                                        (element) => element == songInfo);
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

  void problemDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
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
                          text: '가수와 곡 이름을\n모두 적어 주세요!',
                          letterSpacing: 2.0,
                          fontSize: 20.0,
                          color: Colors.black87,
                          height: 1.5,
                        ))
                  ],
                ),
              ));
        });
  }

  void addSongDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Opacity(
              opacity: 0.9,
              child: Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: _buildChild(context, setState),
              ),
            );
          });
        });
  }

  _buildChild(BuildContext context, StateSetter setDialogState) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/big_dialog.png'), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  return Navigator.of(context).pop(initTextEdit());
                },
                child: const Image(
                  image: AssetImage('assets/exit.png'),
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: const Image(
                      image: AssetImage('assets/text_field.png'),
                      fit: BoxFit.fitHeight),
                ),
                Positioned(
                  bottom: 12,
                  top: 10,
                  left: 40,
                  right: 40,
                  child: TextField(
                    controller: singerNameTextEditController,
                    decoration: const InputDecoration(
                      hintText: '가수',
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
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: const Image(
                      image: AssetImage('assets/text_field.png'),
                      fit: BoxFit.fitHeight),
                ),
                Positioned(
                  bottom: 12,
                  top: 10,
                  left: 40,
                  right: 40,
                  child: TextField(
                    controller: songNameTextEditController,
                    decoration: const InputDecoration(
                      hintText: '곡제목',
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
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const TextFormat(
                      text: 'EG1',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['EG1']] == 5) {
                                  listDifficulty[mapDifficulty['EG1']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['EG1']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['EG1']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'EG2',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['EG2']] == 5) {
                                  listDifficulty[mapDifficulty['EG2']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['EG2']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['EG2']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'AG1',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['AG1']] == 5) {
                                  listDifficulty[mapDifficulty['AG1']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['AG1']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['AG1']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'AG2',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['AG2']] == 5) {
                                  listDifficulty[mapDifficulty['AG2']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['AG2']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['AG2']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'B',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['Bass']] == 5) {
                                  listDifficulty[mapDifficulty['Bass']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['Bass']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['Bass']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const TextFormat(
                      text: 'D',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['Drum']] == 5) {
                                  listDifficulty[mapDifficulty['Drum']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['Drum']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['Drum']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'K1',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['K1']] == 5) {
                                  listDifficulty[mapDifficulty['K1']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['K1']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['K1']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'K2',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['K2']] == 5) {
                                  listDifficulty[mapDifficulty['K2']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['K2']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['K2']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: 'K3',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                        scale: 1.2,
                        child: SizedBox(
                          width: 50,
                          child: TextButton(
                            onPressed: () {
                              setDialogState(() {
                                if (listDifficulty[mapDifficulty['K3']] == 5) {
                                  listDifficulty[mapDifficulty['K3']] = 0;
                                } else {
                                  listDifficulty[mapDifficulty['K3']]++;
                                }
                              });
                            },
                            child: TextFormat(
                              text: textDifficulty[listDifficulty[mapDifficulty['K3']]],
                              fontSize: 12.0,
                              color: Colors.black87,
                              letterSpacing: 1.0,
                            ),
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    const TextFormat(
                      text: '악보',
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                      color: Colors.black87,
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.grey,
                        value: _checkBoxValueScore,
                        onChanged: (value) {
                          setDialogState(() {
                            _checkBoxValueScore = value;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: const Image(
                      image: AssetImage('assets/text_field.png'),
                      fit: BoxFit.fitHeight),
                ),
                Positioned(
                  bottom: 12,
                  top: 10,
                  left: 40,
                  right: 40,
                  child: TextField(
                    controller: remarksTextEditController,
                    decoration: const InputDecoration(
                      hintText: '비고',
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
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: const Image(
                      image: AssetImage('assets/text_field.png'),
                      fit: BoxFit.fitHeight),
                ),
                Positioned(
                  bottom: 12,
                  top: 10,
                  left: 40,
                  right: 40,
                  child: TextField(
                    controller: linkTextEditController,
                    decoration: const InputDecoration(
                      hintText: '링크',
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
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 0, 5, 10),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (singerNameTextEditController.text == '' ||
                        songNameTextEditController.text == '') {
                      problemDialog();  // 가수와 곡 이름을 입력하지 않을 시 입력하라는 팝업창 생성
                    } else {
                      List<int> clone= [...listDifficulty];
                      SongInfo newSong = SongInfo(
                          singerNameTextEditController.text,
                          songNameTextEditController.text,
                          remarksTextEditController.text,
                          linkTextEditController.text,
                          clone,
                          _checkBoxValueScore!);
                      listSongInfo.add(newSong);
                      for(int i = 0; i < listDifficulty.length; i++){
                        listDifficulty[i] = 0;
                      }
                      //api add song info
                      return Navigator.of(context).pop(initTextEdit());
                    }
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Opacity(
          opacity: 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                itemCount: listSongInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onHorizontalDragUpdate: (detail) {
                      if (detail.primaryDelta! > 7.0) {
                        print(detail.primaryDelta);
                        if (listSongInfo.isNotEmpty) {
                          SongInfo deleteSongInfo = listSongInfo[index];
                          deleteDialog(deleteSongInfo);
                        }
                      }
                    },
                    onTap: () {
                      infoDialog(listSongInfo[index],index);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(bottom: 5.0),
              child: TextButton(
                onPressed: () {
                  addSongDialog(context);
                },
                child: const Image(
                  image: AssetImage('assets/plus.png'),
                  width: 45,
                  height: 45,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
