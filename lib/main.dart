import 'package:flutter/material.dart';
import 'package:projeto/login.dart';
import 'package:projeto/cadastro.dart';
//import 'package:projeto/tela_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Login', initialRoute: "/login", routes: {
      "/login": (context) => Login(),
      "/cadastro": (context) => Cadastro(),
      // "/adicionar_receita":(context) => AdicionarReceita(),
      // "/tela_inicial":(context) => TelaInicial()
    });
  }
}
