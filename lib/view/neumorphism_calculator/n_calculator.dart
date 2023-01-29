import 'package:calculator/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class NeumorphismCalculatorPage extends StatefulWidget {
  const NeumorphismCalculatorPage({super.key});

  @override
  State<NeumorphismCalculatorPage> createState() => _NeumorphismCalculatorPageState();
}

class _NeumorphismCalculatorPageState extends State<NeumorphismCalculatorPage> {
  String inputData = "";
  String result = "0";

  List<String> buttonLists = [
    'AC', '(', ')', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '+',
    '1', '2', '3', '-',
    'C', '0',  '.', '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
                    color: Colors.grey.shade800,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(19.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      inputData,
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
                  itemCount: buttonLists.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 25.0,
                    mainAxisSpacing: 25.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomButton(buttonLists[index]);
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
      splashColor: background,
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBtnBgColor(text),
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: lightShadowBgColor,
              blurRadius: 5.5,
              spreadRadius: 0.5,
              offset: Offset(-4.0, -4.0),
            ),
            BoxShadow(
              color: darkShadowBgColor,
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
                color: getTextColor(text),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

// Define Color for text 
  getTextColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == 'C' ||
        text == '(' ||
        text == ')') {
      // return Color(0xFFFC6464);
      return mathExpTextColor;
    }
    if(text == "AC" || text == "="){
      return secondaryTextColor;
    }
    return primaryTextColor;
  }

// Define color for button background
  getBtnBgColor(String text) {
    if (text == 'AC') {
      return mathExpBtnBgColor;
    }
    if (text == '=') {
      return ressultBtnBgColor;
    }
    return secondaryTextColor;
  }

// Handle if user click on the buttons
  handleButton(String text) {
    if (text == "AC") {
      inputData = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (inputData.isNotEmpty) {
        inputData = inputData.substring(0, inputData.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calculate();
      inputData = result;
      if (inputData.endsWith(".0")) {
        inputData = inputData.replaceAll(".0", "");
        return;
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }
    inputData = inputData + text;
  }

// Evaluate tha perfect result according to user input
  String calculate() {
    try {
      var exp = Parser().parse(inputData);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "error!";
    }
  }
  // 
}
