import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keunsori/format/text.dart';

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
