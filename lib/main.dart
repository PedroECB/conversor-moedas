import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=016554d0";

void main() async {
  runApp(MaterialApp(
    title: 'Conversor de Moedas',
    home: Home(),
    theme: ThemeData(hintColor: Colors.white, primaryColor: Colors.amber),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);

  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _realController = TextEditingController();
  final TextEditingController _dollarController = TextEditingController();
  final TextEditingController _euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {

    if (_realController.text == "") {
        _dollarController.text = "";
        _euroController.text = "";
    }

    double real = double.parse(_realController.text);
    _dollarController.text = (real / dolar).toStringAsFixed(2);
    _euroController.text = (real / euro).toStringAsFixed(2);
    print(_realController.text);
  }

  void _dollarChanged(String text) {
    double dol = double.parse(_dollarController.text);
    _realController.text = (dolar/4.15).toStringAsFixed(2);

  }

  void _euroChanged(String text) {
    print("Campo euro");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(
//          "CONVERSOR DE MOEDAS",
//          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//        ),
//        centerTitle: true,
//        backgroundColor: Colors.teal,
//      ),
      backgroundColor: Colors.teal,
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados :(",
                    style: TextStyle(color: Colors.redAccent, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(25.0, 70.0, 25.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                            border: OutlineInputBorder(),
                            prefixText: "R\$",
                            prefixStyle: TextStyle(
                                color: Colors.amber,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.amber),
                          controller: _realController,
                          onChanged: _realChanged,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Dólares",
                            labelStyle: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            prefixText: "US\$",
                            prefixStyle: TextStyle(
                                color: Colors.amber,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.amber),
                          controller: _dollarController,
                          onChanged: _dollarChanged,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Euro",
                            labelStyle: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
                            border: OutlineInputBorder(),
                            prefixText: "\€",
                            prefixStyle: TextStyle(
                                color: Colors.amber,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.amber),
                          controller: _euroController,
                          onChanged: _euroChanged,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Center(
                          child: Text(
                            "Desenvolvido por: Pedro Henrique Carvalho",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
          }
//          return ;
        },
      ),
    );
  }
}
