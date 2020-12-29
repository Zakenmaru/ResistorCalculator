import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

// List of different variables required for this
List<String> colors = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white'
];

Map<String, String> colorsToNumbers = {
  'black': '0',
  'brown': '1',
  'red': '2',
  'orange': '3',
  'yellow': '4',
  'green': '5',
  'blue': '6',
  'violet': '7',
  'grey': '8',
  'white': '9'
};

Map<String, Color> colorsToColors = {
  'black': Colors.black,
  'brown': Colors.brown,
  'red': Colors.red,
  'orange': Colors.orange,
  'yellow': Colors.yellow,
  'green': Colors.green,
  'blue': Colors.blue,
  'violet': Color(0xFF8F00FF),
  'grey': Colors.grey,
  'white': Colors.white
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // calculations
  String ohms = "None";
  String text = "Please fill in all 3 colors!";

  String checkValid(String col1, String col2, String col3) {
    return (col1 == null || col2 == null || col3 == null)
        ? "Please fill in all 3 colors for "
        : calcOhms(col1, col2, col3);
  }

  String calcOhms(String col1, String col2, String col3) {
    // calculate the two numbers put together
    String twoDigString = colorsToNumbers[col1] + colorsToNumbers[col2];
    int firstTwoDig = int.parse(twoDigString);
    // calculate the power of the third
    int multiplier = pow(10, int.parse(colorsToNumbers[col3]));
    debugPrint("$multiplier");
    int totOhms = firstTwoDig * multiplier;
    return totOhms.toStringAsExponential(3);
  }

  changeText() {
    setState(
      () {
        text = 'Value of the Resistor: $ohms Ω';
      },
    );
  }

  String val1, val2, val3;

  //thematic stuff
  final Color mainColor = Colors.black;
  final TextStyle font = GoogleFonts.lato();
  final hintText = "Resistor Colors are read from left to right!";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(bodyText1: font).apply(bodyColor: Colors.black),
        appBarTheme: AppBarTheme(color: mainColor),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("3-Band Resistor Calculator"),
          
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('$hintText')),
            Row(
              children: <Widget>[
                /*First Button*/
                DropdownButton<String>(
                  value: val1,
                  items: colors.map(
                    (String color) {
                      return new DropdownMenuItem<String>(
                        child: new BorderedText(
                          strokeWidth: 0.5,
                          child: Text(
                            color,
                            style: TextStyle(
                              color: colorsToColors[color],
                            ),
                          ),
                        ),
                        value: color,
                      );
                    },
                  ).toList(),
                  onChanged: (String newValue) {
                    setState(
                      () {
                        val1 = newValue;
                        ohms = checkValid(val1, val2, val3);
                        changeText();
                      },
                    );
                  },
                ),
                /*Second Button*/
                DropdownButton<String>(
                  value: val2,
                  items: colors.map(
                    (String color) {
                      return new DropdownMenuItem<String>(
                        child: new BorderedText(
                          strokeWidth: 0.5,
                          child: Text(
                            color,
                            style: TextStyle(
                              color: colorsToColors[color],
                            ),
                          ),
                        ),
                        value: color,
                      );
                    },
                  ).toList(),
                  onChanged: (String newValue) {
                    setState(
                      () {
                        val2 = newValue;
                        ohms = checkValid(val1, val2, val3);
                        changeText();
                      },
                    );
                  },
                ),
                /*Third Button*/
                DropdownButton<String>(
                  value: val3,
                  items: colors.map(
                    (String color) {
                      return new DropdownMenuItem<String>(
                        child: new BorderedText(
                          strokeWidth: 0.5,
                          child: Text(
                            color,
                            style: TextStyle(
                              color: colorsToColors[color],
                            ),
                          ),
                        ),
                        value: color,
                      );
                    },
                  ).toList(),
                  onChanged: (String newValue) {
                    setState(
                      () {
                        val3 = newValue;
                        ohms = checkValid(val1, val2, val3);
                        changeText();
                      },
                    );
                  },
                ),
              ],
            ),

            // IconButton(
            //   icon: Icon(Icons.play_arrow),
            //   tooltip: 'Check the Ohms!',
            //   onPressed: () {
            //     ohms = checkValid(val1, val2, val3);
            //     changeText();
            //   },
            // ),
            Center(
              child: Text('$text'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class OhmButton extends StatefulWidget {
  String val;
  OhmButton({
    Key key,
    this.val,
  }) : super(key: key);
  @override
  _OhmButtonState createState() => _OhmButtonState();
}

class _OhmButtonState extends State<OhmButton> {
  @override
  Widget build(BuildContext context) {
    String val = widget.val;
    return DropdownButton<String>(
      value: val,
      items: colors.map(
        (String color) {
          return new DropdownMenuItem<String>(
            child: new Text(
              color,
              style: TextStyle(color: Colors.black),
            ),
            value: color,
          );
        },
      ).toList(),
      onChanged: (String newValue) {
        setState(
          () {
            val = newValue;
            ohms = checkValid(val1, val2, val3);
            changeText();
          },
        );
      },
    );
  }
}
*/
