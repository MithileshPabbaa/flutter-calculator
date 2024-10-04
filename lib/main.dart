import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  const MyCalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String expression = '';
  String result = '';

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        expression = '';
        result = '';
      } else if (buttonText == '=') {
        try {
          Expression exp = Expression.parse(expression);
          const evaluator = ExpressionEvaluator();
          var evalResult = evaluator.eval(exp, {});
          result = '$expression = $evalResult';
          expression = evalResult.toString();
        } catch (e) {
          result = 'Error';
          expression = '';
        }
      } else {
        expression += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            backgroundColor: color,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mithilesh\'s Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                expression,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton('7', Colors.grey[200]!),
                  buildButton('8', Colors.grey[200]!),
                  buildButton('9', Colors.grey[200]!),
                  buildButton('/', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('4', Colors.grey[200]!),
                  buildButton('5', Colors.grey[200]!),
                  buildButton('6', Colors.grey[200]!),
                  buildButton('*', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('1', Colors.grey[200]!),
                  buildButton('2', Colors.grey[200]!),
                  buildButton('3', Colors.grey[200]!),
                  buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton('0', Colors.grey[200]!),
                  buildButton('C', Colors.red),
                  buildButton('=', Colors.green),
                  buildButton('+', Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
