import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/api_model.dart';
import '../../repositories/contato/contato_repository_impl.dart';
import '../novo/novo_contato.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var backRepo = ContatoRepositoryImpl();
  RetornoBack4AppModel retornoBack4App = RetornoBack4AppModel(results: []);
  String mensagemAguarde = 'Consultando Aguarde!!....';
  bool habilitarMensagemAguarde = true;
  @override
  void initState() {
    getDados();
    super.initState();
  }

  Future<void> getDados() async {
    atualizarTela(true);
    final dados = await backRepo.obterTodos();
    setState(() {
      retornoBack4App = dados;
    });
    atualizarTela(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda de Contatos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NovoContato()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Visibility(
                visible: habilitarMensagemAguarde,
                child: Text(
                  mensagemAguarde,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: retornoBack4App.results.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NovoContato(
                            dadosContato: retornoBack4App.results[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Image.file(
                              File(retornoBack4App.results[index].path!),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: Text(retornoBack4App.results[index].nome!),
                            subtitle: Text(retornoBack4App.results[index].telefone!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void atualizarTela(bool mensagemAguarde) {
    setState(() {
      habilitarMensagemAguarde = mensagemAguarde;
    });
  }
}
