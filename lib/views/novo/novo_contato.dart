import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/api_model.dart';
import '../../models/contato.dart';
import '../../repositories/contato/contato_repository_impl.dart';
import '../home/home_page.dart';

class NovoContato extends StatefulWidget {
  final Results? dadosContato;
  const NovoContato({super.key, this.dadosContato});

  @override
  State<NovoContato> createState() => _NovoContatoState();
}

class _NovoContatoState extends State<NovoContato> {
  final TextEditingController _ctrlNome = TextEditingController();
  final TextEditingController _ctrlTelefone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var backRepo = ContatoRepositoryImpl();
  String pathFoto = '';
  final ImagePicker picker = ImagePicker();
  File? _selectedImage;
  bool salvando = false;

  @override
  void dispose() {
    _ctrlNome.dispose();
    _ctrlTelefone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.dadosContato != null) {
      setState(() {
        _ctrlNome.text = widget.dadosContato!.nome!;
        _ctrlTelefone.text = widget.dadosContato!.telefone!;
        pathFoto = widget.dadosContato!.path!;

        if (pathFoto.trim().isNotEmpty) {
          _selectedImage = File(pathFoto);
        } else {
          _selectedImage = null;
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.dadosContato == null ? const Text('Novo Contato') : const Text('Editar Contato'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _ctrlNome,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null) {
                        return 'Informe o nome';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    controller: _ctrlTelefone,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null) {
                        return 'Informe o e-mail';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _selectedImage != null
                    ? InkWell(
                        onTap: () async {
                          await tirarFoto(context);
                        },
                        child: Image.file(
                          _selectedImage!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          await tirarFoto(context);
                        },
                        child: const SizedBox(
                          width: 250,
                          height: 250,
                          child: Icon(
                            Icons.camera_alt,
                            size: 200,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: !salvando,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _selectedImage != null
                            ? () async {
                                if (_formKey.currentState!.validate() && _selectedImage != null) {
                                  exibirCarregando(true);
                                  final contato = Contato(
                                    nome: _ctrlNome.text,
                                    telefone: _ctrlTelefone.text,
                                    path: _selectedImage!.path,
                                  );
                                  widget.dadosContato == null
                                      ? await backRepo.criarContato(contato)
                                      : await backRepo.atualizarContato(contato, widget.dadosContato!.objectId!);
                                  if (context.mounted) {
                                    _showToast(context, 'O Contato foi salvo com sucesso!!');
                                    setState(() {
                                      _selectedImage = null;
                                    });
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                }
                                exibirCarregando(false);
                              }
                            : null,
                        child: const Text('Salvar'),
                      ),
                      const SizedBox(width: 20),
                      Visibility(
                        visible: widget.dadosContato != null,
                        child: ElevatedButton(
                          onPressed: () async {
                            exibirCarregando(true);
                            await backRepo.excluirContato(widget.dadosContato!.objectId!);
                            exibirCarregando(false);
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                                (Route<dynamic> route) => false,
                              );
                            }
                          },
                          child: const Text('Excluir'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        child: const Text('Nova Foto'),
                        onPressed: () async {
                          await tirarFoto(context);
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: salvando,
                  child: const Column(
                    children: [
                      SizedBox(height: 20),
                      Text('Aguarde salvando o contato!.........'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> tirarFoto(BuildContext context) async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      pathFoto = photo?.path != null ? photo!.path : '';
      if (pathFoto.trim().isNotEmpty) {
        _selectedImage = File(pathFoto);
      } else {
        _selectedImage = null;
      }
    });
  }

  void exibirCarregando(bool carregando) {
    setState(() {
      salvando = carregando;
    });
  }

  void _showToast(BuildContext context, String mensagem) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }
}
