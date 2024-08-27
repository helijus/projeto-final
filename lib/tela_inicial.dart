import 'package:flutter/material.dart';
//import 'package:projeto/login.dart';
import 'package:projeto/model/usuario.dart';
import 'package:projeto/barranavegacao.dart';
import 'package:projeto/pesquisar_receita.dart';

class TelaInicial extends StatefulWidget {
  final Usuario usuario;

  TelaInicial(this.usuario);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _itemSelecionado = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Barranavegacao(usuario: widget.usuario),
        appBar: AppBar(
          title: Text('Bem-vindo, ${widget.usuario.nome}'),
        ),
        body: Center(
          child: Text('E-mail: ${widget.usuario.email}'),
        ),
        // Adicione aqui o restante do código da tela inicial
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.yellow,
          items: const [
            BottomNavigationBarItem(
                label: 'Lista de Compras', icon: Icon(Icons.shopping_cart)),
            BottomNavigationBarItem(
                label: 'Minha Despensa', icon: Icon(Icons.star_border)),
            BottomNavigationBarItem(
                label: 'Pesquisar Receita', icon: Icon(Icons.search))
          ],
          currentIndex: _itemSelecionado,
          onTap: (idx) {
            setState(() {
              if (idx == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PesquisarReceita()));
              }
              _itemSelecionado = idx;
            });
          },
        ));
  }
}
