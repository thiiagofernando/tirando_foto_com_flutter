class RetornoBack4AppModel {
  List<Results> results = [];

  RetornoBack4AppModel({required this.results});

  RetornoBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results.isNotEmpty) {
      data['results'] = results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? nome;
  String? telefone;
  String? path;
  Results({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.nome,
    required this.telefone,
    required this.path,
  });

  Results.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    nome = json['nome'];
    telefone = json['telefone'];
    path = json['path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['path'] = path;
    return data;
  }
}
