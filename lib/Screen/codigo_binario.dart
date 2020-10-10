import 'package:flutter/material.dart';

class CodigoBinario extends StatefulWidget {
  @override
  _CodigoBinarioState createState() => _CodigoBinarioState();
}

class _CodigoBinarioState extends State<CodigoBinario> {

  //variaveis de erros de numeros nao binarios
  String onErrorField1 = '';
  String onErrorField2 = '';

  //variaveis dos campos para receber os numeros binarios
  String weight;
  String height;

  //validacao para receber numeros entre 0-255
  String validateFirstBinaryNumberValue(String value) {
    try {
      RegExp recognizingNonBinaryNumbers = RegExp("[2-9]");
      if (recognizingNonBinaryNumbers.hasMatch(value)) {
        return "Insira um número binário valido";
      } else if (((0 <=
          int.tryParse(((int.parse(value, radix: 2)).toRadixString(10))))) &
      ((int.tryParse(((int.parse(value, radix: 2)).toRadixString(10)))) <=
          255)) {
        return null;
      } else {
        return "Insira um número entre 0 e 255";
      }
    } catch (e) {
      return "";
    }
  }

  //controles de edicao dos fields
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //apresentação de texto e resultados
  String _infoText = "Informe binários para calculo!";
  String _infoTextX = "";
  String _infoTextD = "";
  String _infoTextR = "";

  //reset dos fields
  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe número binários";
      _infoTextX = "";
      _infoTextD = "";
      _infoTextR = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  //estado e funcao para calcular os binarios
  void _calculate() {
    setState(() {
      String weight = weightController.text;
      String height = heightController.text;

      if (weight != null && height != null) {
        int resultNumber;
        resultNumber =
            int.tryParse(((int.parse(weight, radix: 2)).toRadixString(10))) +
                int.tryParse(((int.parse(height, radix: 2)).toRadixString(10)));
        _infoText = ('Soma: ' + (resultNumber).toRadixString(2));

        int resultNumberX;
        resultNumberX = (int.tryParse(
            ((int.parse(weight, radix: 2)).toRadixString(10)))) *
            (int.tryParse(((int.parse(height, radix: 2)).toRadixString(10))));
        _infoTextX = ('Multiplicação: ' + (resultNumberX).toRadixString(2));

        int resultNumberD;
        if ((int.tryParse(((int.parse(height, radix: 2)).toRadixString(10)))) !=
            0) {
          resultNumberD = (int.tryParse(
              ((int.parse(weight, radix: 2)).toRadixString(10)))) ~/
              (int.tryParse(((int.parse(height, radix: 2)).toRadixString(10))));
          _infoTextD = ('Divisão: ' + (resultNumberD).toRadixString(2));
        } else {
          _infoTextD = "Escolha um divisor diferente de 0";
        }
        int resultNumberS;
        resultNumberS =
            int.tryParse(((int.parse(weight, radix: 2)).toRadixString(10))) -
                int.tryParse(((int.parse(height, radix: 2)).toRadixString(10)));
        _infoTextR = ('Subtração ${(resultNumberS).toRadixString(2)}');
      } else {
        _infoText = "Não foi possivel realizar operação!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Binários"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.input, size: 120.0, color: Colors.indigo),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    onErrorField1 = validateFirstBinaryNumberValue(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: onErrorField1,
                    labelText: "Informe Primeiro Binários",
                    labelStyle: TextStyle(
                        fontSize: 14.0, color: Colors.deepOrangeAccent)),
                textAlign: TextAlign.center,
                style:
                TextStyle(color: Colors.deepOrangeAccent, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    onErrorField2 = validateFirstBinaryNumberValue(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: onErrorField2,
                    labelText: "Informe Segundo Binário",
                    labelStyle: TextStyle(
                        fontSize: 14.0, color: Colors.deepOrangeAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepOrange, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo Obrigatório";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(validateFirstBinaryNumberValue(
                            weightController.text));
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.indigo,
                  ),
                    ),
                ),

              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 25.0),
              ),
              Text(
                _infoTextX,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 25.0),
              ),
              Text(
                _infoTextD,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 25.0),
              ),
              Text(
                _infoTextR,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}