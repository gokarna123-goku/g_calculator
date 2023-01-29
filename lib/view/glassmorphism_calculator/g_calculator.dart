import 'package:flutter/material.dart';
import 'package:calculator/constants/colors.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:math_expressions/math_expressions.dart';

class GlassmorphismCalculatorPage extends StatefulWidget {
  const GlassmorphismCalculatorPage({super.key});

  @override
  State<GlassmorphismCalculatorPage> createState() =>
      _GlassmorphismCalculatorPageState();
}

class _GlassmorphismCalculatorPageState
    extends State<GlassmorphismCalculatorPage> {
  String inputData = "";
  String result = "0";
  String longPressText = "Developed by Goku";

// list of butttons
  List<String> buttonLists = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://cdn.pixabay.com/photo/2022/12/10/20/35/desert-7647700__340.jpg",
              ),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.8,
                // decoration: BoxDecoration(
                //   // color: Color(0xFF1d2630),
                //   borderRadius: BorderRadius.circular(0),
                // ),
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
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      // splashColor: background,
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      // onLongPress: (){
      //   setState(() {
      //     inputData = longPressText;
      //     return;
      //   });
      // },
      // onDoubleTap: (){
      //   setState(() {
      //     inputData = longPressText;
      //     return;
      //   });
      // },
      child: GlassmorphicContainer(
        blur: 0.0,
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        borderRadius: 7.0,
        padding: EdgeInsets.all(10.0),
        linearGradient: LinearGradient(
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
          colors: [
            lightShadowBgColor.withOpacity(0.4),
            primaryTextColor.withOpacity(0.2),
          ],
          // stops: [0.3, 1],
        ),
        borderGradient: LinearGradient(
          // begin: Alignment.bottomRight,
          // end: Alignment.topLeft,
          colors: [
            primaryTextColor,
            Color(0xFFFFFFF),
            Color(0xFFF75035),
          ],
          tileMode: TileMode.clamp,
          // stops: [0.65, 0.95, 1],
        ),
        border: 0,
        child: Ink(
          decoration: BoxDecoration(
            // color: getBtnBgColor(text),
            borderRadius: BorderRadius.circular(7.0),
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
    if (text == "AC" || text == "=") {
      return mathExpTextColor;
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
