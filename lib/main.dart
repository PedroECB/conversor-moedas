import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors&key=016554d0";


void main() async{

  http.Response response = await http.get(request);
  dynamic data = json.decode(response.body)["results"]["currencies"];

  print(data);

  runApp(MaterialApp(
    title: 'Conversor de Moedas',
    home:Container(
      color:Colors.white,
    ),
  ));
}