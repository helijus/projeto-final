import 'dart:core';
import 'package:flutter/material.dart';
import 'package:projeto/adicionarReceita.dart';
import 'package:projeto/database/database_helper.dart';
//import 'package:projeto/perfilUsuario.dart';
import 'package:projeto/tela_inicial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remover a tag de debug
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  final String title = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UsuarioDB usuarioDb = UsuarioDB();
  final TextEditingController email = TextEditingController();
  final TextEditingController senha = TextEditingController();
  String resultado = '';

  _login() async {
    print('Método _login chamado');
    await usuarioDb.listarUsuarioLogin(email.text, senha.text).then((usuario) {
      if (usuario != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TelaInicial(usuario)),
          //MaterialPageRoute(builder: (context) => TelaPerfil(usuario: usuario)),
          //MaterialPageRoute(builder: (context) => AdicionarReceita()),
          //MaterialPageRoute(builder: (context) => AdicionarReceita()),
        );
      } else {
        setState(() {
          resultado = 'Usuário não encontrado';
        });
      }
    }).catchError((error) {
      debugPrint("Erro no login:" + error.toString());
      setState(() {
        resultado = 'Erro na tentativa de login';
      });
    });
  }

  _cadastro() {
    Navigator.pushNamed(context, '/cadastro');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho com logo e título
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.all(40.0),
              width: double.infinity,
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png', // Substitua pelo caminho correto do seu logo
                    height: 80,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Despensa Chefe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Área de formulário
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Lógica para mudar para a tela de login
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: _cadastro,
                        child: const Text(
                          'Cadastro',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Entrar'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Lógica para "Esqueci minha senha"
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  if (resultado.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        resultado,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
