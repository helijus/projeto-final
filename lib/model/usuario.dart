class Usuario {
  int? id;
  String nome = '';
  String email = '';
  String senha = '';
  String fotoPerfil = '';

  Usuario({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.fotoPerfil = '',
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'email': email,
      'senha': senha,
      'fotoPerfil': fotoPerfil,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Usuario.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    senha = map['senha'];
    fotoPerfil = map['fotoPerfil'];
  }
}
