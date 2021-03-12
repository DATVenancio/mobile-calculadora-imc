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
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";
  String _sexoText = "Informe seu sexo";

  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";

    setState(() {
      _infoText = "Informe seus dados";
      _sexoText = "Informe seu sexo";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;

      double imc = weigth / (heigth * heigth);

      if(_sexoText=="Masculino"){
        if (imc < 20.0) {
          _infoText = "ABAIXO DO PESO!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 20.0 && imc <25.0){
          _infoText = "PESO IDEAL!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 25.0 && imc <30.0){
          _infoText = "OBESIDADE LEVE!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 30.0 && imc <40.0){
          _infoText = "OBESIDADE MODERADA!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 40.0 ){
          _infoText = "OBESIDADE MÓRBIDA!(IMC ${imc.toStringAsPrecision(3)})";
        }

      }
      else if(_sexoText=="Feminino"){
        if (imc < 19.0) {
          _infoText = "ABAIXO DO PESO!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 19.0 && imc <24.0){
          _infoText = "PESO IDEAL!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 24.0 && imc <29.0){
          _infoText = "OBESIDADE LEVE!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 29.0 && imc <39.0){
          _infoText = "OBESIDADE MODERADA!(IMC ${imc.toStringAsPrecision(3)})";
        }
        else if(imc >= 39.0 ){
          _infoText = "OBESIDADE MÓRBIDA!(IMC ${imc.toStringAsPrecision(3)})";
        }
      }else{
        _infoText = "INFORME SEU SEXO!";
      }

    });
  }

  void _sexo(String sexo){
    setState(() {
      if(sexo=='m'){
        _sexoText = "Masculino";
      }
      else if(sexo=='f'){
        _sexoText = "Feminino";
      }
    });

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120.0, color: Colors.blue),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                      child: Container(
                        height: 40.0,
                        width: 120.0,
                        child: RaisedButton(
                            child: Text(
                              "MASCULINO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              _sexo('m');
                            }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Container(
                        height: 40.0,
                        width: 120.0,
                        child: RaisedButton(
                            child: Text(
                              "FEMININO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              _sexo('f');
                            }),
                      ),
                    ),
                  ],
                ),
                Text(
                  "$_sexoText",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 15.0),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  controller: weigthController,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua altura!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                  controller: heigthController,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        }),
                  ),
                ),
                Text(
                  "$_infoText",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 20.0),
                ),
              ],
            ),
          )),
    );
  }
}
