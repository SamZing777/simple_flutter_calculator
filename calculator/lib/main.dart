import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}


class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      title: 'Calculator',
      home: CalculatorResponse(),
    );
  }
}


class CalculatorResponse extends StatefulWidget {

  @override
  _CalculatorResponseState createState() => _CalculatorResponseState();
}

class _CalculatorResponseState extends State<CalculatorResponse> {

  double font_size = 30.0, operatorBtnSize = 1.25;
  Color genColor = Colors.black54, operatorBtn = Colors.greenAccent;

  String equation = '0', result = '0', expression = '0';
  double equationFontSize = 35.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == 'C'){
          equation = '0';
          result = '0';
      }

      else if(buttonText == '-1'){
          equation = equation.substring(0, equation.length - 1);
      }

      else if(buttonText == '='){

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

          try{
              Parser parser = Parser();
              Expression exp = parser.parse(expression);

              ContextModel ctx = ContextModel();
              result = '${exp.evaluate(EvaluationType.REAL, ctx)}';

          }
          catch(e){
              result = 'Error';
          }
      }

      else{
        if(equation == '0'){
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Colors.white54,
              width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(15.0),

        onPressed: (){
            buttonPressed(buttonText);
        },

        child: Text(
          buttonText, style: TextStyle(fontSize: font_size,
            fontWeight: FontWeight.bold, color: Colors.white54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ebuddie Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: font_size)),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: 50.0)),
          ),

          Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('-1', 1, Colors.blueAccent),
                        buildButton('÷', 1, Colors.lightBlueAccent),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton('7', 1, genColor),
                          buildButton('8', 1, genColor),
                          buildButton('9', 1, genColor),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('4', 1, genColor),
                          buildButton('5', 1, genColor),
                          buildButton('6', 1, genColor),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('3', 1, genColor),
                          buildButton('2', 1, genColor),
                          buildButton('1', 1, genColor),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('.', 1, genColor),
                          buildButton('00', 1, genColor),
                          buildButton('0', 1, genColor),
                        ]
                    ),
                  ]
                )
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton('×', operatorBtnSize, operatorBtn),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton('-', operatorBtnSize, operatorBtn),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('+', operatorBtnSize, operatorBtn),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('=', operatorBtnSize, genColor),
                        ]
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
