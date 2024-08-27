import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto/database/database_helper.dart';
import 'package:projeto/model/receita.dart';
import 'package:image_picker/image_picker.dart';

class AdicionarReceita extends StatefulWidget {
  @override
  _AdicionarReceitaState createState() => _AdicionarReceitaState();
}

class _AdicionarReceitaState extends State<AdicionarReceita> {
  final _nomeController = TextEditingController();
  String? _selectedCategoria;
  final _ingredientesController = TextEditingController();
  final _modoPreparoController = TextEditingController();
  XFile? _imagemSelecionada;

  final UsuarioDB _usuarioDb = UsuarioDB();

  final List<String> _categorias = ['Entrada', 'Prato Principal', 'Sobremesa'];

  void _adicionarReceita() async {
    print('Método _adicionarReceita chamado');
    final nome = _nomeController.text;
    final categoria = _selectedCategoria;
    final ingredientes = _ingredientesController.text;
    final modoPreparo = _modoPreparoController.text;

    if (nome.isEmpty ||
        categoria == null ||
        ingredientes.isEmpty ||
        modoPreparo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    final receita = Receita(
      nome: nome,
      categoria: categoria,
      ingredientes: ingredientes,
      modoPreparo: modoPreparo,
      imagem: _imagemSelecionada?.path ?? '',
    );

    await _usuarioDb.inserirReceita(receita);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receita adicionada com sucesso')),
    );
  }

  void _adicionarImagem() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF29727),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        title: const Text('Adicionar Receita',
            style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Nome:'),
                              const SizedBox(height: 8),
                              TextField(
                                controller: _nomeController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Categoria:'),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                value: _selectedCategoria,
                                items: _categorias.map((categoria) {
                                  return DropdownMenuItem(
                                    value: categoria,
                                    child: Text(categoria),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategoria = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Ingredientes:'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _ingredientesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Modo de preparo:'),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _modoPreparoController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Adicionar imagem:'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _adicionarImagem,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_upload),
                              SizedBox(width: 8),
                              Text('Selecionar arquivo'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_imagemSelecionada != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Image.file(File(_imagemSelecionada!.path)),
                      ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFFF29727),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: _adicionarReceita,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Enviar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
