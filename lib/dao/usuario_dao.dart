/*import 'package:projeto/database/db_helper.dart';
import 'package:projeto/model/usuario.dart';

class UsuarioDAO {
  //inserir usuario
  static Future<int> inserir(Usuario usuario) async {
    var db = await DBHelper.getInstance();
    return await db.insert('usuario', usuario.toMap());
  }

  //atualizar Usuario
  static Future<void> atualizar(Usuario usuario) async {
    var db = await DBHelper.getInstance();
    await db.update(
      'usuario',
      usuario.toMap(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  //deletar
  static Future<void> deletar(Usuario usuario) async {
    var db = await DBHelper.getInstance();
    await db.delete('usuario', where: 'id = ?', whereArgs: [usuario.id]);
  }

  //listar usuarios (acredito que não será implementado no front)
  static Future<Usuario?> listarUsuario(String email, String senha) async {
    var db = await DBHelper.getInstance();
    List<Map> result = await db.query(
      'usuario',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first as Map<String, dynamic>);
    } else {
      return null; // talvez retorne uma mensagem para o usuário se cadastrar?
    }
  }
}
*/