class Receita {
  final int? id;
  final String nome;
  final String categoria;
  final String ingredientes;
  final String modoPreparo;
  final String imagem;

  Receita({
    this.id,
    required this.nome,
    required this.categoria,
    required this.ingredientes,
    required this.modoPreparo,
    this.imagem = '',
  });

  // Convertir Receita para um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'ingredientes': ingredientes,
      'modo_preparo': modoPreparo,
      'imagem': imagem,
    };
  }

  // Criar uma Receita a partir de um mapa
  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'],
      nome: map['nome'],
      categoria: map['categoria'],
      ingredientes: map['ingredientes'],
      modoPreparo: map['modo_preparo'],
      imagem: map['imagem'],
    );
  }
}
