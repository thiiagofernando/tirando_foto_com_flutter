import '../../models/api_model.dart';
import '../../models/contato.dart';

abstract class ContatoRepository {
  Future<RetornoBack4AppModel> obterTodos();
  Future<void> atualizarContato(Contato contato, String contatoId);
  Future<void> criarContato(Contato contato);
  Future<void> excluirContato(String contatoId);
}
