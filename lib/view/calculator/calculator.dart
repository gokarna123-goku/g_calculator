import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String userInput = "";
  String result = "";

  List<String> buttonList = [
    'AC', '(', ')', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '+',
    '1', '2', '3', '-',
    'C', '0',  '.', '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.8,
              decoration: BoxDecoration(
                color: Color(0xFF1d2630),
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 1.0,
                    color: Colors.grey.shade800, // background color
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 32.0, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                          fontSize: 48.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.2, color: Colors.grey.shade800),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 25.0,
                    mainAxisSpacing: 25.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(buttonList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBGColor(text),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 5.5,
              spreadRadius: 0.5,
              offset: Offset(-4.0, -4.0),
            ),
            BoxShadow(
              color: Colors.black87,
              blurRadius: 5.5,
              spreadRadius: 0.5,
              offset: Offset(6.0, 6.0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: getColor(text),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == 'C' ||
        text == '(' ||
        text == ')') {
      // return Color(0xFFFC6464);
      return Color(0xFF6478FC);
    }
    if(text == "AC" || text == "="){
      return Color(0xFF1d2630);
    }
    return Colors.white;
  }

  getBGColor(String text) {
    if (text == 'AC') {
      return Color(0xFF6478FC);
    }
    if (text == '=') {
      return Color(0xFFC85D36);
    }
    return Color(0xFF1d2630);
  }

  handleButton(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
        return;
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "error";
    }
  }
}
