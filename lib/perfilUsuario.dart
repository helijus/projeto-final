import 'dart:io'; // Import necessário para File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto/database/database_helper.dart';
import 'package:projeto/model/usuario.dart';

class TelaPerfil extends StatefulWidget {
  final Usuario usuario; // Recebe o usuário que fez o login

  TelaPerfil({required this.usuario});

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  final UsuarioDB usuarioDb = UsuarioDB();
  late TextEditingController nomeController;
  late TextEditingController emailController;
  late TextEditingController senhaController;
  XFile? _fotoPerfil;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.usuario.nome);
    emailController = TextEditingController(text: widget.usuario.email);
    senhaController = TextEditingController(text: widget.usuario.senha);

    // Carregar a foto de perfil do usuário
    if (widget.usuario.fotoPerfil.isNotEmpty) {
      _fotoPerfil = XFile(widget.usuario.fotoPerfil);
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  void _salvarAlteracoes() async {
    Usuario usuarioAtualizado = Usuario(
      id: widget.usuario.id,
      nome: nomeController.text,
      email: emailController.text,
      senha: senhaController.text,
      fotoPerfil: _fotoPerfil?.path ??
          widget.usuario.fotoPerfil, // Atualiza a foto de perfil
    );

    await usuarioDb.atualizarUsuario(usuarioAtualizado);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
    );
  }

  Future<void> _selecionarFotoPerfil() async {
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFF29727),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFF29727),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _selecionarFotoPerfil,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _fotoPerfil != null
                          ? FileImage(File(_fotoPerfil!.path))
                          : widget.usuario.fotoPerfil.isNotEmpty
                              ? FileImage(File(widget.usuario.fotoPerfil))
                              : null,
                      child: _fotoPerfil == null &&
                              widget.usuario.fotoPerfil.isEmpty
                          ? const Icon(Icons.add_a_photo, color: Colors.black)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    nomeController.text, // Exibe o nome do usuário
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('Nome:', nomeController),
                  _buildTextField('E-mail:', emailController),
                  _buildTextField('Senha:', senhaController, isPassword: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _salvarAlteracoes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Salvar Alterações'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
