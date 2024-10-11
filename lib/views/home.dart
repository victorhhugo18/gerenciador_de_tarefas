// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:gerenciador_de_tarefas/model/bd.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> tarefas = [];

  @override
  void initState() {
    super.initState();
    _loadTarefas();
  }

  Future<void> _loadTarefas() async {
    final tarefaList =
        await Bd.instance.getTarefas(); 
    setState(() {
      tarefas = tarefaList;
    });
  }

  // Inserir uma nova tarefa e atualizar a lista
  Future<void> _addTarefa(
      String titulo, String subtitulo, String data_criacao) async {
    await Bd.instance
        .criarTarefa(titulo, subtitulo, data_criacao); // Insere a tarefa
    _loadTarefas(); // Atualiza a lista de tarefas
  }

  // Atualizar a tarefa
  Future<void> _updateTarefa(
      int id, String titulo, String subtitulo, String data_criacao) async {
    await Bd.instance
        .updateTarefa(id, titulo, subtitulo, data_criacao); // Atualiza o pedido
    _loadTarefas(); // Atualiza a lista de pedidos
  }

  // Excluir um pedido
  Future<void> _deleteTarefa(int id) async {
    await Bd.instance.deleteTarefa(id);
    _loadTarefas(); // Atualiza a lista de pedidos
  }

  void _showEditDialogAtualizar(BuildContext context, int id, String titulo,
      String subtitulo, String data_criacao) {
    TextEditingController tituloController =
        TextEditingController(text: titulo);
    TextEditingController subtituloController =
        TextEditingController(text: subtitulo);
    TextEditingController dataController =
        TextEditingController(text: data_criacao);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text("Atualizar Tarefa",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  prefixIcon: Icon(Icons.title,
                      color: const Color.fromARGB(255, 21, 77, 105)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subtituloController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.subtitles,
                      color: const Color.fromARGB(255, 21, 77, 105)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: dataController,
                decoration: InputDecoration(
                  labelText: 'Data de Criação',
                  prefixIcon: Icon(Icons.calendar_today,
                      color: const Color.fromARGB(255, 21, 77, 105)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 21, 77, 105),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Atualizar"),
              onPressed: () {
                _updateTarefa(
                  id,
                  tituloController.text,
                  subtituloController.text,
                  dataController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialogCriar(BuildContext context) {
    TextEditingController tituloController = TextEditingController();
    TextEditingController subtituloController = TextEditingController();
    TextEditingController dataController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              "Criar Nova Tarefa",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  prefixIcon: Icon(Icons.title,
                      color: const Color.fromARGB(255, 21, 77, 105)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: subtituloController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.subtitles,
                      color: const Color.fromARGB(255, 21, 77, 105)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: dataController,
                decoration: InputDecoration(
                  labelText: 'Data de Criação',
                  prefixIcon: Icon(Icons.calendar_today,
                      color: const Color.fromARGB(255, 21, 77, 105)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 21, 77, 105),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Salvar"),
              onPressed: () {
                _addTarefa(
                  tituloController.text,
                  subtituloController.text,
                  dataController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TAREFAS'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 21, 77, 105),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Tela de listagem de tarefas
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.shade100, 
                        shape: BoxShape.circle, 
                      ),
                      child: Icon(
                        Icons.task,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      tarefas[index]['titulo'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tarefas[index]['subtitulo']),
                        SizedBox(height: 4),
                        Text(
                          'Data: ${tarefas[index]['data_criacao']}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _showEditDialogAtualizar(
                            context,
                            tarefas[index]['id'],
                            tarefas[index]['titulo'],
                            tarefas[index]['subtitulo'],
                            tarefas[index]['data_criacao'],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.confirm,
                                title: 'Atenção!',
                                text: 'Deseja excluir a tarefa?',
                                confirmBtnText: 'Sim',
                                cancelBtnText: 'Não',
                                confirmBtnColor:
                                    const Color.fromARGB(255, 37, 120, 131),
                                onConfirmBtnTap: () {
                                  _deleteTarefa(tarefas[index]['id']);
                                  Navigator.of(context).pop();
                                },
                                onCancelBtnTap: () =>
                                    Navigator.of(context).pop(),
                              );
                            }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 21, 77, 105),
        foregroundColor: Colors.white,
        onPressed: () => _showEditDialogCriar(context),
      ),
    );
  }
}
