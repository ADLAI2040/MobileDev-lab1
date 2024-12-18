import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() {
    return _CaculatorState();
  }
}

class _CaculatorState extends State<Calculator> {
  Widget createCalcButton(
      String buttonText, Color buttonColor, Color textColor) {
    return Container(
      child: ElevatedButton(
        onPressed: error == false
            ? () => {
                  inputText(buttonText),
                }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: EdgeInsets.all(20),
          minimumSize: Size(80, 80),
          shape: CircleBorder(),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            color: textColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'CALCULATOR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "$text",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '$currentText',
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: currentText.length > 10 ? 40 : 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      inputText("C");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(170, 80),
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      'C',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  createCalcButton('^', Colors.blue, Colors.white),
                  createCalcButton('/', Colors.blue, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  createCalcButton('7', Colors.white, Colors.black),
                  createCalcButton('8', Colors.white, Colors.black),
                  createCalcButton('9', Colors.white, Colors.black),
                  createCalcButton('*', Colors.blue, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  createCalcButton('4', Colors.white, Colors.black),
                  createCalcButton('5', Colors.white, Colors.black),
                  createCalcButton('6', Colors.white, Colors.black),
                  createCalcButton('-', Colors.blue, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  createCalcButton('1', Colors.white, Colors.black),
                  createCalcButton('2', Colors.white, Colors.black),
                  createCalcButton('3', Colors.white, Colors.black),
                  createCalcButton('+', Colors.blue, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: error == false
                        ? () => {
                              inputText("0"),
                            }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(170, 80),
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  createCalcButton('.', Colors.blue, Colors.white),
                  createCalcButton('=', Colors.blue, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String text = "";
  String currentText = "0";
  double firstNum = 0;
  double secondNum = 0;
  double? result;
  bool error = false;

  void inputText(buttonText) {
    if (buttonText == "C") {
      text = "";
      currentText = "0";
      error = false;
    } else {
      if (error != true) {
        if (buttonText == "=") {
          if (currentText.endsWith('.')) {
            currentText = currentText + "0";
          }

          text = text + currentText + buttonText;

          if (text.contains(
              RegExp(r'[0-9]+[\.]?[0-9]*[\+\-\/\*\^][0-9]+[\.]?[0-9]*'))) {
            calculation();
            text = "";
          } else {
            text = "Incorrect Input";
            error = true;
          }
        } else {
          if (buttonText == "+" ||
              buttonText == "-" ||
              buttonText == "*" ||
              buttonText == "/" ||
              buttonText == "^") {
            if (currentText.endsWith('.')) {
              currentText = currentText + "0";
            }

            if (!text.contains(RegExp(r'[\+\-\*\^\/]'))) {
              text = text + currentText + buttonText;
              currentText = "";
            }
          } else {
            if (buttonText == ".") {
              if (!currentText.contains('.') && currentText.isNotEmpty) {
                currentText = currentText + buttonText;
              }
            } else {
              if (currentText == "0") {
                currentText = buttonText;
              } else {
                if (currentText.length < 15) {
                  currentText = currentText + buttonText;
                }
              }
            }
          }
        }
      }
    }

    setState(() {
      text;
      currentText;
    });
  }

  void calculation() {
    const pattern =
        r'(?<firstNum>[0-9]+[\.]?[0-9]*)(?<operation>[\+\-\/\*\^])(?<secondNum>[0-9]+[\.]?[0-9]*)';

    final equation = RegExp(
      pattern,
    );

    RegExpMatch equationMatch = equation.firstMatch(text)!;
    firstNum = double.parse(equationMatch.namedGroup('firstNum')!);
    secondNum = double.parse(equationMatch.namedGroup('secondNum')!);
    String operation = equationMatch.namedGroup('operation')!;

    operation == "+"
        ? result = add(firstNum, secondNum)
        : operation == "-"
            ? result = sub(firstNum, secondNum)
            : operation == "*"
                ? result = mult(firstNum, secondNum)
                : operation == "/"
                    ? result = div(firstNum, secondNum)
                    : result = pow(firstNum, secondNum).toDouble();

    if (result != null && result != double.infinity) {
      currentText = result.toString();
    } else {
      if (result == null) {
        currentText = "Error";
      }

      if (result == double.infinity) {
        currentText = "Infinity";
      }

      error = true;
    }

    setState(() {
      currentText;
    });
  }

  double add(double num1, double num2) {
    return num1 + num2;
  }

  double sub(double num1, double num2) {
    return num1 - num2;
  }

  double mult(double num1, double num2) {
    return num1 * num2;
  }

  double? div(double num1, double num2) {
    if (num2 == 0) {
      return null;
    }
    return num1 / num2;
  }
}
