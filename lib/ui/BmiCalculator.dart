import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';


class BmiCalculator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BmiCalculatorState();
  }
}

class BmiCalculatorState extends State<BmiCalculator>{
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double _bmiResult = 0.0;
  String _formattedText = "";
  String _description = "";
  String _finalDescription = "";

  void bmiCalculateHandler(){
    setState(() {
      _bmiResult = bmiCalculate(_heightController.text, _weightController.text);
      _formattedText = _bmiResult.toStringAsFixed(1);
      _finalDescription = bmiDescription();

      SystemChannels.textInput.invokeMethod('TextInput.hide');

    });
  }
  /*
* Severe Thinness	< 16
  Moderate Thinness	16 - 17
  Mild Thinness	17 - 18.5
  Normal	18.5 - 25
  Overweight	25 - 30
  Obese Class I	30 - 35
  Obese Class II	35 - 40
Obese Class III	> 40
  * */
  String bmiDescription(){
    if(_bmiResult < 16) {
      _description = "Severe Thinness";
    }
    else if(_bmiResult >= 16 && _bmiResult < 17){
      _description = "Moderate Thinness";
    }
    else if (_bmiResult >= 17 && _bmiResult < 18.5){
      _description = "Mild Thinness";
    }
    else if(_bmiResult >= 18.5 && _bmiResult < 25){
      _description = "Normal";
    }
    else if(_bmiResult >= 25 && _bmiResult < 30){
      _description = "Overweight";
    }
    else if(_bmiResult >= 30 && _bmiResult < 35){
      _description = "Obese Class I";
    }
    else if(_bmiResult >= 35 && _bmiResult < 40){
      _description = "Obese Class II";
    }
    else if(_bmiResult >= 40){
      _description = "Obese Class III";
    }
    else{
      _description = "Value is not defined";
    }

    return _description;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'BMI Calculator',
        ),
        centerTitle: true,
        backgroundColor: Colors.magenta,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: EdgeInsets.all(2.5),
          children: <Widget>[
            Image.asset('assets/images/bmilogo.png',
            height: 100,
            width: 189,
            ),
            Container(
              color: Colors.liteGrey,
              margin: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  TextField(
                    //autofocus: true,
                    controller: null,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      icon: Icon(Icons.person_outline),
                    ),
                  ),
                  TextField(
                    //autofocus: true,
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Height',
                      hintText: 'in cm',
                      icon: Icon(Icons.insert_chart),
                    ),
                  ),
                  TextField(
                    //autofocus: true,
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      hintText: 'in kg',
                      icon: Icon(Icons.calendar_view_day),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.6)),
                  Container(
                    //margin: EdgeInsets.only(top: 10),
                    child:
                    RaisedButton(
                      onPressed: bmiCalculateHandler,
                      color: Colors.magenta,
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Your BMI: $_formattedText ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                  Text('$_finalDescription',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.magenta,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  double bmiCalculate(String height, String weight) {
    if(int.parse(height).toString().isNotEmpty && int.parse(height).toString().isNotEmpty && int.parse(height) > 0 && double.parse(weight) > 0){
      return double.parse(weight) / (pow(double.parse(height) / 100, 2));
    }
  }
}