import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<Map> _recuperaPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response;

    response = await http.get(Uri.parse(url));
    return json.decode( response.body);

  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
        future: _recuperaPreco(),
        builder: (context, snapshot){
          String resultado;
          switch( snapshot.connectionState ){
            case ConnectionState.none:
            case ConnectionState.waiting:
              print("waiting");
              resultado = "Carregando...";
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              print("done");
              if( snapshot.hasError ){
                resultado = "Erro ao carregar os dados...";
              }else{
                double valor = snapshot.data!["USD"]["buy"];
                resultado = "Preço do BitCoin: ${valor.toString()}";
              }
              break;
          }
          
          return Center(
            child: Text(resultado),
          );
        },
    );
  }
}
