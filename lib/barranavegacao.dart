import 'package:flutter/material.dart';
import 'package:projeto/adicionarReceita.dart';
import 'package:projeto/login.dart';
import 'package:projeto/model/usuario.dart';
import 'package:projeto/perfilUsuario.dart';

class Barranavegacao extends StatelessWidget {
  final Usuario usuario;
  Barranavegacao({required this.usuario});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange,
      child: ListView(
        children: [
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaPerfil(usuario: usuario)),
              );
            },
          ),
          ListTile(
            title: Text('Minha Despensa'),
            /*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DespensaPage()),
              );
            },*/
          ),
          ListTile(
            title: Text('Lista de Compras'),
            /*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaComprasPage()),
              );
            },*/
          ),
          ListTile(
            title: Text('Receitas Salvas'),
            /*onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReceitasSalvasPage()),
              );
            },*/
          ),
          ListTile(
            title: Text('Adicionar Receita'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdicionarReceita()),
              );
            },
          ),
          ListTile(
            title: Text('Receitas Pendentes'),
            /* onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReceitasPendentes()),
              );
            },*/
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
