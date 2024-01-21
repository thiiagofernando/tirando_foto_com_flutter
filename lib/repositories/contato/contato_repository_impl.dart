import '../../core/rest_client/api_client.dart';
import '../../models/api_model.dart';
import '../../models/contato.dart';
import 'contato_repository.dart';

class ContatoRepositoryImpl implements ContatoRepository {
  final ApiClientCustom dio = ApiClientCustom();
  final String url = 'contatos';
  @override
  Future<void> atualizarContato(Contato contato, String contatoId) async {
    await dio.api.put('$url/$contatoId', data: contato.toJson());
  }

  @override
  Future<void> criarContato(Contato contato) async {
    await dio.api.post(url, data: contato.toJson());
  }

  @override
  Future<void> excluirContato(String contatoId) async {
    await dio.api.delete('$url/$contatoId');
  }

  @override
  Future<RetornoBack4AppModel> obterTodos() async {
    final result = await dio.api.get(url);
    return RetornoBack4AppModel.fromJson(result.data);
  }
}
