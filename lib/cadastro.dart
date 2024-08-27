import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto/database/database_helper.dart';
import 'package:projeto/model/usuario.dart';
import 'package:image_picker/image_picker.dart';

class Cadastro extends StatefulWidget {
  final String title = 'Cadastro';

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  UsuarioDB usuarioDb = UsuarioDB();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController confirmarSenha = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String resultado = '';
  XFile? _fotoPerfil;

  @override
  void dispose() {
    // Limpe controladores ou outras assinaturas aqui
    nome.dispose();
    email.dispose();
    senha.dispose();
    confirmarSenha.dispose();
    super.dispose();
  }

  _cadastrar() async {
    if (nome.text.isEmpty || email.text.isEmpty || senha.text.isEmpty) {
      if (mounted) {
        setState(() {
          resultado = 'Preencha todos os dados';
        });
      }
    } else {
      if (!formKey.currentState!.validate()) {
        if (mounted) {
          setState(() {
            resultado = 'Favor verificar os campos';
          });
        }
        return;
      }
      if (senha.text != confirmarSenha.text) {
        if (mounted) {
          setState(() {
            resultado = 'As senhas são diferentes';
          });
        }
      } else {
        if (mounted) {
          setState(() {
            resultado = 'Cadastro realizado';
          });
        }
        _salvarDadosCadastrados();
        if (mounted) {
          Navigator.pop(context, '/login');
        }
      }
    }
  }

  _salvarDadosCadastrados() async {
    Usuario usuario = Usuario(
      nome: nome.text,
      email: email.text,
      senha: senha.text,
      fotoPerfil: _fotoPerfil?.path ?? '', // Salva o caminho da foto de perfil
    );

    // Tratamento de erro ao inserir o usuário
    try {
      await usuarioDb.inserirUsuario(usuario);
      print("Quantidade usuários: ${await usuarioDb.getCount()}");
    } catch (e) {
      setState(() {
        resultado = 'Erro ao salvar os dados: $e';
      });
    }
  }

  _selecionarFotoPerfil() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _fotoPerfil = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
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
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey, // Vincula o formulário ao formKey
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Campo de foto de perfil
                    GestureDetector(
                      onTap: _selecionarFotoPerfil,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _fotoPerfil != null
                            ? FileImage(File(_fotoPerfil!.path))
                            : null,
                        child: _fotoPerfil == null
                            ? const Icon(Icons.add_a_photo, color: Colors.black)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nome,
                      decoration: InputDecoration(
                        hintText: 'Nome',
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
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: confirmarSenha,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirmar Senha',
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
                      onPressed: _cadastrar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Cadastrar'),
                    ),
                    const SizedBox(height: 10),
                    if (resultado.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          resultado,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
