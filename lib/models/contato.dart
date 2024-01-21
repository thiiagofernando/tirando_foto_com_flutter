import 'dart:convert';

class Contato {
  String? nome;
  String? telefone;
  String? path;
  Contato({
    required this.nome,
    required this.telefone,
    required this.path,
  });

  Contato copyWith({
    String? objectId,
    String? nome,
    String? telefone,
    String? path,
  }) {
    return Contato(
      nome: nome ?? nome,
      telefone: telefone ?? this.telefone,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'telefone': telefone,
      'path': path,
    };
  }

  factory Contato.fromMap(Map<String, dynamic> map) {
    return Contato(
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Contato.fromJson(String source) => Contato.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Contato(nome: $nome, telefone: $telefone, path: $path)';

  @override
  bool operator ==(covariant Contato other) {
    if (identical(this, other)) return true;

    return other.nome == nome && other.telefone == telefone && other.path == path;
  }

  @override
  int get hashCode => nome.hashCode ^ telefone.hashCode ^ path.hashCode;
}
