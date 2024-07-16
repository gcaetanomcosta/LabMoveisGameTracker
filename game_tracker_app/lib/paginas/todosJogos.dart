// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';

class TodosJogos extends StatefulWidget {
  static const String rota = "/todosJogos";

  @override
  State<TodosJogos> createState() => _TodosjogosState();
}

class _TodosjogosState extends State<TodosJogos> {
  ControladorJogos ctrlJogos = ControladorJogos();
  DatabaseHelper dbHelper = DatabaseHelper();

  late Future<List<Jogo>> allGames;

  int linhaJOgos = 4;

  @override
  void initState() {
    super.initState();

    allGames = incicializarTodosJogos();
  }

  Future<List<Jogo>> incicializarTodosJogos() async {

    List<Jogo> jogos = await ctrlJogos.getTodosJogos();

    if (jogos.isEmpty) {
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 41,
          user_id: 50,
          name: "Link",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 42,
          user_id: 50,
          name: "Mario",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 43,
          user_id: 50,
          name: "Luigi",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 44,
          user_id: 50,
          name: "Pokémon",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 45,
          user_id: 50,
          name: "Pikachu",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 46,
          user_id: 50,
          name: "LOL",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 47,
          user_id: 50,
          name: "DOTA",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
    }

    jogos = await ctrlJogos.getTodosJogos();

    return jogos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos os Jogos"),
        ),
        body: FutureBuilder<List<Jogo>>(
          future: allGames,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
               return Center(child: Text('Nenhum jogo encontrado.'));
            } else {
                final jogos = snapshot.data!;
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text("Lista de Jogos"),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final itemSize = constraints.maxWidth / linhaJOgos;
                          return AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    GridView.builder(
                                      itemCount: jogos.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: linhaJOgos,
                                        childAspectRatio: 1,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Card(
                                          margin: EdgeInsets.all(5),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration:
                                                  BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(10)),
                                              margin: EdgeInsets.all(5),
                                              width: itemSize,
                                              //height: itemSize,
                                              child: Center(
                                                child: Text(jogos[index].name ?? 'Sem nome'),
                                              ),
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
                        },
                      ),
                    ],
                  )
                );
            }
          }
 
        )
          
      );
      
  }
}
