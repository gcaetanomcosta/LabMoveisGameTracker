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

  int linhaJOgos = 3;

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
          description: "Embarque em uma busca épica para salvar o reino de Hyrule. Adquira novas habilidades, use a icônica Master Sword além de itens especiais, que ajudam a superar obstáculos e derrotar inimigos.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 42,
          user_id: 50,
          name: "Mario",
          description: "Explore lugares incríveis longe do Reino Cogumelo com o Mario e o novo aliado Cappy em uma imensa aventura 3D ao redor do mundo.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 43,
          user_id: 50,
          name: "Luigi",
          description: "Luigi deve explorar um hotel assombrado, incorporando temáticas diferentes em cada andar, e resgatar seus amigos dos fantasmas que o habitam.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 44,
          user_id: 50,
          name: "Pokémon",
          description: "Capture, lute e treine Pokémon na região de Paldea, uma vasta área cheia de lagos, picos imponentes, desertos, vilarejos e cidades em expansão. Explore o mundo aberto montado no Pokémon lendário que muda de forma",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 45,
          user_id: 50,
          name: "Pikachu",
          description: "Capture e colecione Pokémon em uma aventura diversa e vibrante no jogo Pokémon™: Torne-se o melhor Treinador de Pokémon que puder, enquanto batalha outros Treinadores, Líderes de Ginásios e a sinistra Equipe Rocket.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 46,
          user_id: 50,
          name: "LOL",
          description: "Jogo de estratégia onde duas equipes de cinco campeões se enfrentam para destruir a base adversária. Escolha entre mais de 140 campeões para fazer jogadas épicas, garantir mortes e derrubar torres enquanto luta para chegar à vitória.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 47,
          user_id: 50,
          name: "DOTA",
          description: "Jogo de equipe competitivo com elementos de RPG. Duas equipes rivais (Iluminados e Temidos) com cinco jogadores cada. O objetivo principal é destruir o Ancestral inimigo dentro de sua fortaleza.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 48,
          user_id: 50,
          name: "Hades",
          description: "Hades é um RPG de ação e exploração de masmorras rogue-like. Utilize o poder de armas míticas do Olimpo para escapar das garras do deus da morte, ficando cada vez mais forte a cada nova tentativa de fuga.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 49,
          user_id: 50,
          name: "Hades 2",
          description: "No papel da princesa do Submundo, explore um mundo mitológico mais amplo e instigante enquanto subjuga as forças do titã do tempo com todo o poder do Olimpo ao seu lado em uma história arrebatadora.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 50,
          user_id: 50,
          name: "Overwacth",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 51,
          user_id: 50,
          name: "Marvel Rivals",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 52,
          user_id: 50,
          name: "Stardew Valley",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 53,
          user_id: 50,
          name: "Elden Ring",
          description: "Qualquer coisa",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 54,
          user_id: 50,
          name: "Baldur's gate 3",
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
          backgroundColor: Colors.amber,
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
                      Expanded(
                        child: GridView.builder(
                          itemCount: jogos.length,
                          //shrinkWrap: true,
                          //physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: linhaJOgos,
                            childAspectRatio: 1 / 1.5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.amber,
                              margin: EdgeInsets.all(5),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(5),
                                  //width: itemWidth,
                                  //height: itemHeight,
                                  child: Center(
                                    child: Text(jogos[index].name ?? 'Sem nome'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
 
        )
          
      );
      
  }
}
