import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dart:math';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ty Mitchell - Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _expression = "";
  String _result = "0";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _expression = "";
        _result = "0";
      } else if (buttonText == "=") {
        try {
          final expression = Expression.parse(_expression);
          if (_expression.contains('/0')) {
            _result = "Error";
          } else {
            final evaluator = const ExpressionEvaluator();
            final result = evaluator.eval(expression, {});
            _result = result.toString();
          }
        } catch (e) {
          _result = "Error";
        }
      } else if (buttonText == "√") {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = sqrt(result).toString();
        } catch (e) {
          _result = "Error";
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ty Mitchell - Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  _result,
                  style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/"),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*"),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-"),
                ],
              ),
              Row(
                children: [
                  _buildButton("."),
                  _buildButton("0"),
                  _buildButton("00"),
                  _buildButton("+"),
                ],
              ),
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("="),
                  _buildButton("√"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
