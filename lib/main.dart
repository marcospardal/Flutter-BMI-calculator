import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Insert your weight and height.";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleReset() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Insert your weight and height.";
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double bmi = weight / (height * height);

    setState(() {
      if (bmi <= 18.5) {
        _infoText = "(${bmi.toStringAsPrecision(4)}) Underweight.";
      } else if (bmi <= 25) {
        _infoText = "(${bmi.toStringAsPrecision(4)}) Normal.";
      } else {
        _infoText = "(${bmi.toStringAsPrecision(4)}) Overweight.";
      }
    });
  }

  Color _getResultColor() {
    if (_infoText.contains('Nomal'))
      return Colors.yellow;
    else if (_infoText.contains('Underweight'))
      return Colors.blue;
    else if (_infoText.contains('Underweight')) return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style: TextStyle(fontFamily: 'Raleway', color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                color: Colors.black,
                onPressed: _handleReset)
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline_rounded,
                      size: 120, color: Colors.black),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insert your weight!.";
                      }
                    },
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Weight (kg):",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return "Insert your height!.";
                    },
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Height (cm):",
                        labelStyle: TextStyle(color: Colors.black)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Raleway'),
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _infoText.contains('Normal')
                              ? Colors.green
                              : _infoText.contains('Underweight')
                                  ? Colors.blue
                                  : _infoText.contains('Overweight')
                                      ? Colors.red
                                      : Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _infoText,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Raleway',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
