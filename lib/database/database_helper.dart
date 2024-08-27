import 'package:projeto/model/usuario.dart';
import 'package:projeto/model/receita.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDB {
  Future<Database> _criarBanco() async {
    // await _deleteDatabase(); - Função para caso precisar apagar o banco para depois criar de novo
    final caminhoDb = await getDatabasesPath();
    final localDb = caminhoDb + "despensa-chefe.db";

    var result = await openDatabase(
      localDb,
      version: 1,
      onCreate: (Database db, int version) async {
        // Cria as tabelas ao inicializar o banco de dados
        print('Criando tabelas...');
        await _criarUsuario(db);
        await _criarReceitas(db);
        print('Tabelas criadas.');
      },
    );
    print("Banco criado: " + result.isOpen.toString());
    return result;
  }

  //CRIANDO AS TABELAS
  Future<void> _criarUsuario(Database db) async {
    const String sql = 'CREATE TABLE IF NOT EXISTS '
        'usuario('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'nome TEXT,'
        'email TEXT,'
        'senha TEXT,'
        'fotoPerfil TEXT)';
    await db.execute(sql);
  }

  Future<void> _criarReceitas(Database db) async {
    const String sqlReceita = 'CREATE TABLE IF NOT EXISTS '
        'receitas('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'nome TEXT,'
        'categoria TEXT,'
        'ingredientes TEXT,'
        'modo_preparo TEXT,'
        'imagem TEXT)';
    await db.execute(sqlReceita);
  }

  /*Caso a gente precise limpar o banco de dados
 Future<void> _deleteDatabase() async {
    final caminhoDb = await getDatabasesPath();
    final localDb = caminhoDb + 'despensa-chefe.db';
    await deleteDatabase(localDb);
  }*/

  inserirUsuario(Usuario usuario) async {
    Database db = await _criarBanco();
    var result = await db.insert('usuario', usuario.toMap());
    print("Usuario criado:" + result.toString());
    return result;
  }

  atualizarUsuario(Usuario usuario) async {
    Database db = await _criarBanco();
    var result = await db.update('usuario', usuario.toMap(),
        where: 'id = ?', whereArgs: [usuario.id]);
    print("Usuario atualizado:" + result.toString());
    return result;
  }

  listarUsuario(int id) async {
    Database db = await _criarBanco();
    List<Map> usuarios = await db.query('usuario',
        columns: ['id', 'nome', 'email', 'senha', 'fotoPerfil'],
        where: 'id = ?',
        whereArgs: [id]);

    if (usuarios.isEmpty) {
      var usuario = usuarios.first;
      print("id: " +
          usuario['id'] +
          "nome: " +
          usuario['nome'] +
          "email:" +
          usuario['email'] +
          "senha: " +
          usuario['senha'] +
          "fotoPerfil: " +
          usuario['fotoPerfil']);
      return Usuario.fromMap(usuario);
    } else {
      return null;
    }
  }

  listarUsuarioLogin(String email, String senha) async {
    Database db = await _criarBanco();
    List<Map<String, dynamic>> usuarios = await db.query(
      'usuario',
      columns: ['id', 'nome', 'email', 'senha', 'fotoPerfil'],
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    if (usuarios.isNotEmpty) {
      var usuario = usuarios.first;
      print("id: " +
          usuario['id'].toString() + // Converte o ID para string se necessário
          " nome: " +
          usuario['nome'] +
          " email: " +
          usuario['email'] +
          " senha: " +
          usuario['senha'] +
          "fotoPerfil: " +
          usuario['fotoPerfil']);

      return Usuario.fromMap(usuario);
    } else {
      return null;
    }
  }

  getCount() async {
    Database db = await _criarBanco();
    const String sql = 'SELECT COUNT(*) '
        'FROM usuario';
    List<Map<String, dynamic>> queryResult = await db.rawQuery(sql);
    int? result = Sqflite.firstIntValue(queryResult);
    print('Quantidade de usuários no momento:' + result.toString());
    return result;
  }

  inserirReceita(Receita receita) async {
    Database db = await _criarBanco();
    var result = await db.insert('receitas', receita.toMap());
    print("Receita criado:" + result.toString());
    return result;
  }

  atualizarReceita(Receita receita) async {
    Database db = await _criarBanco();
    var result = await db.update('receitas', receita.toMap(),
        where: 'id = ?', whereArgs: [receita.id]);
    print("Receita atualizado:" + result.toString());
    return result;
  }

  listarReceitas(int id) async {
    Database db = await _criarBanco();
    List<Map<String, dynamic>> receitas = await db.query(
      'receitas',
      columns: [
        'id',
        'nome',
        'categoria',
        'ingredientes',
        'modo_preparo',
        'imagem'
      ],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (receitas.isNotEmpty) {
      var receita = receitas.first
          .cast<String, dynamic>(); // Cast to Map<String, dynamic>
      print("id: " +
          receita['id'].toString() + // Ensure ID is converted to string
          " nome: " +
          receita['nome'] +
          " categoria: " +
          receita['categoria'] +
          " ingredientes: " +
          receita['ingredientes'] +
          " modo_preparo: " +
          receita['modo_preparo'] +
          " imagem: " +
          receita['imagem']);

      return Receita.fromMap(receita);
    } else {
      return null;
    }
  }

  getCountReceitas() async {
    Database db = await _criarBanco();
    const String sql = 'SELECT COUNT(*) '
        'FROM receitas';
    List<Map<String, dynamic>> queryResult = await db.rawQuery(sql);
    int? result = Sqflite.firstIntValue(queryResult);
    print('Quantidade de receitas no momento:' + result.toString());
    return result;
  }

  close() async {
    Database db = await _criarBanco();
    db.close();
  }
}
