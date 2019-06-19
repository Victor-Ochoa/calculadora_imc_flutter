import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var weightController = TextEditingController();
  var heightController = TextEditingController();

  var _infoText = "Informe seus dados.";

  var _formkey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      _formkey.currentState.reset();
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados.";
    });
  }

  void _calculate() {
    var weight = double.parse(weightController.text);
    var height = double.parse(heightController.text) / 100;

    var imc = weight / (height * height);

    setState(() {
      if (imc < 18.6)
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      else if (imc >= 18.6 && imc < 24.9)
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      else if (imc >= 24.9 && imc < 29.9)
        _infoText = "Acima do Peso (${imc.toStringAsPrecision(3)})";
      else if (imc >= 29.9 && imc < 34.9)
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      else if (imc >= 34.9 && imc < 39.9)
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      else if (imc >= 39.9)
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 20.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty)
                      return "Insira seu Peso";
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 20.0)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty)
                    return "Insira sua Altura";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 25),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formkey.currentState.validate())
                        _calculate();
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
