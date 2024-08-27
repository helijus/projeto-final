import 'dart:core';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto/database/database_helper.dart';
import 'package:projeto/model/receita.dart';
import 'package:projeto/model/usuario.dart';
import 'package:sqflite/sqflite.dart';

class PesquisarReceita extends StatefulWidget {
  final String salve = 'salve';

  _PesquisarReceitaState createState() => _PesquisarReceitaState();
}

class _PesquisarReceitaState extends State<PesquisarReceita> {
  UsuarioDB usuarioDb = UsuarioDB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Pesquisar Receita',
                ),
              ),
              ListTile(
                title: Text('qqr coisa'),
                subtitle: Text('descrição da receita'),
              )
            ],
          )),
    );
  }
}
