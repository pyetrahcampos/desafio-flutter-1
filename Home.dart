import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();

}

class HomeState extends State<Home> {

  String resultado = "o cep irá aparecer aqui";


  TextEditingController txtcep = TextEditingController();

  void buscacep() async {cd C:\Users\pyetr\Downloads\flutter_windows_3.29.2-stable\flutter\.git\desafio1
    String cep = txtcep.text;
    String url = 'https://viacep.com.br/ws/$cep/json/';

    flutter run 


    http.Response response;

    response = await http.get(url);

    print ("resposta:" + response.body);
     print ("resposta:" + response.statusCode.toString());


     Map<String, dynamic> dados = json.decode(response.body);

  String logradouro = dados["logradouro"];
String complemento = dados["complemento"];
String bairro = dados["bairro"];
String localidade = dados["localidade"];

String endereço = "o endereço é: $logradouro, $complemento, $bairro, $localidade";

setState(() {
  resultado = endereço;
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta CEP'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Seu CEP',
                  labelStyle: TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
              ),
              ElevatedButton(
  child: Text('Consultar'),
  onPressed: buscacep, 
),

              ),
              Text('O endereço irá aparecer aqui'),
            ,
          ),
        ),
      );,
  }
}