import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}


class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _input,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              buildButtonRow(['C', '⌫']),
              buildButtonRow(['7', '8', '9', '%']),
              buildButtonRow(['4', '5', '6', 'x']),
              buildButtonRow(['1', '2', '3', '-']),
              buildButtonRow(['0', '+']),
              buildButtonRow(['=']),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget buildButtonRow(List<String> buttons) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons
            .map(
              (button) => buildButton(button),
            )
            .toList(),
      ),
    );
  }

  Widget buildButton(String buttonText) {
    double buttonSize = (buttonText == '0' || buttonText == 'C')
        ? 6.0
        : buttonText == '='
            ? 4.0
            : 2.0;
    double buttonSpacing =
        (buttonText == '9' || buttonText == '%' || buttonText == 'C')
            ? 4.0
            : 2.0;
    double buttonHeight = (buttonText == '⌫') ? 10.0 : buttonSize;

    return Expanded(
      flex: (buttonText == 'C') ? 2 : buttonSize.toInt(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: buttonSpacing),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            primary: buttonText == '='
                ? Color.fromARGB(255, 156, 242, 75)
                : getButtonColor(buttonText),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            padding: EdgeInsets.all(16.0),
          ),
          child: Container(
            child: buttonText == '⌫'
                ? Icon(Icons.backspace, size: 20.0)
                : Text(
                    buttonText,
                    style: TextStyle(fontSize: 24.0),
                  ),
          ),
        ),
      ),
    );
  }

  Color getButtonColor(String buttonText) {
  if (buttonText == 'C') {
    return Colors.yellow; 
  } else if (
      buttonText == '⌫' ||
      buttonText == '%' ||
      buttonText == 'x' ||
      buttonText == '-' ||
      buttonText == '+') {
    return Colors.yellow;
  } else {
    return Color.fromARGB(255, 144, 239, 250);
  }
}


  void onButtonPressed(String buttonText) {
  setState(() {
    if (buttonText == 'C') {
      _input = '0';
    } else if (buttonText == '⌫') {
      _input = _input.isNotEmpty ? _input.substring(0, _input.length - 1) : '0';
    } else if (buttonText == '=') {
      _input = _calculateResult();
    } else {
      // ถ้า _input เป็น '0' และผู้ใช้กดปุ่มตัวเลขใดๆ ใหม่
      if (_input == '0') {
        _input = buttonText;
      } else {
        _input += buttonText;
      }
    }
  });
}


  String _calculateResult() {
    try {
      return eval(_input).toString();
    } catch (e) {
      return 'Error';
    }
  }

  dynamic eval(String expression) {
    return Function.apply(
      () {},
      [],
      expression as Map<Symbol, dynamic>?,
    );
  }
}
