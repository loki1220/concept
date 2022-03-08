import 'package:flutter/material.dart';

class NumericPad extends StatelessWidget {
  // final Function(int) onNumberSelected;

  // NumericPad({@required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      /*decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF28B6ED),
            Color(0xFFE063FF),
          ],
        ),
      ),*/
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(1),
                buildNumber(2),
                buildNumber(3),
              ],
            ),
          ),
          Container(
            //height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(4),
                buildNumber(5),
                buildNumber(6),
              ],
            ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(7),
                buildNumber(8),
                buildNumber(9),
              ],
            ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height * 0.11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildEmptySpace(),
                buildNumber(0),
                buildBackspace(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumber(int number) {
    return GestureDetector(
      onTap: () {
        null;
        //onNumberSelected(number);
      },
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace() {
    return GestureDetector(
      onTap: () {
        null;
        //onNumberSelected(-1);
      },
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Icon(
            Icons.backspace,
            size: 28,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildEmptySpace() {
    return Container();
  }
}
