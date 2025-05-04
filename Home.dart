import 'package:flutter/material.dart';
import 'Home.dart';

import 'dart:convert';


void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String resultado = "O endereço irá aparecer aqui";
  TextEditingController txtcep = TextEditingController();

  void buscacep() async {
    String cep = txtcep.text.trim();
    if (cep.isEmpty) {
      setState(() {
        resultado = "Digite um CEP válido.";
      });
      return;
    }

    String url = 'https://viacep.com.br/ws/$cep/json/';

    try {
      var http;
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> dados = json.decode(response.body);

        if (dados.containsKey("erro")) {
          setState(() {
            resultado = "CEP não encontrado.";
          });
        } else {
          String logradouro = dados["logradouro"] ?? '';
          String complemento = dados["complemento"] ?? '';
          String bairro = dados["bairro"] ?? '';
          String localidade = dados["localidade"] ?? '';

          setState(() {
            resultado =
            "Endereço: $logradouro, $complemento, $bairro, $localidade";
          });
        }
      } else {
        setState(() {
          resultado = "Erro na consulta: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        resultado = "Erro: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta CEP'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: txtcep,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite seu CEP',
                labelStyle: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: buscacep,
              child: Text('Consultar'),
            ),
            SizedBox(height: 24),
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
