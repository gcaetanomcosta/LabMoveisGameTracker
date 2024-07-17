// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:game_tracker_app/paginas/login.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/paginas/pageJogo.dart';
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

  List<Jogo> searchGames = [];
  List<Jogo> filteredGames = [];

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
          description:
              "Embarque em uma busca épica para salvar o reino de Hyrule. Adquira novas habilidades, use a icônica Master Sword além de itens especiais, que ajudam a superar obstáculos e derrotar inimigos.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 42,
          user_id: 50,
          name: "Mario",
          description:
              "Explore lugares incríveis longe do Reino Cogumelo com o Mario e o novo aliado Cappy em uma imensa aventura 3D ao redor do mundo.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 43,
          user_id: 50,
          name: "Luigi",
          description:
              "Luigi deve explorar um hotel assombrado, incorporando temáticas diferentes em cada andar, e resgatar seus amigos dos fantasmas que o habitam.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 44,
          user_id: 50,
          name: "Pokémon",
          description:
              "Capture, lute e treine Pokémon na região de Paldea, uma vasta área cheia de lagos, picos imponentes, desertos, vilarejos e cidades em expansão. Explore o mundo aberto montado no Pokémon lendário que muda de forma",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 45,
          user_id: 50,
          name: "Pikachu",
          description:
              "Capture e colecione Pokémon em uma aventura diversa e vibrante no jogo Pokémon™: Torne-se o melhor Treinador de Pokémon que puder, enquanto batalha outros Treinadores, Líderes de Ginásios e a sinistra Equipe Rocket.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 46,
          user_id: 50,
          name: "LOL",
          description:
              "Jogo de estratégia onde duas equipes de cinco campeões se enfrentam para destruir a base adversária. Escolha entre mais de 140 campeões para fazer jogadas épicas, garantir mortes e derrubar torres enquanto luta para chegar à vitória.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 47,
          user_id: 50,
          name: "DOTA",
          description:
              "Jogo de equipe competitivo com elementos de RPG. Duas equipes rivais (Iluminados e Temidos) com cinco jogadores cada. O objetivo principal é destruir o Ancestral inimigo dentro de sua fortaleza.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 48,
          user_id: 50,
          name: "Hades",
          description:
              "Hades é um RPG de ação e exploração de masmorras rogue-like. Utilize o poder de armas míticas do Olimpo para escapar das garras do deus da morte, ficando cada vez mais forte a cada nova tentativa de fuga.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 49,
          user_id: 50,
          name: "Hades 2",
          description:
              "No papel da princesa do Submundo, explore um mundo mitológico mais amplo e instigante enquanto subjuga as forças do titã do tempo com todo o poder do Olimpo ao seu lado em uma história arrebatadora.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 50,
          user_id: 50,
          name: "Overwacth",
          description:
              "Como um hero shooter, Overwatch designa jogadores em dois times de seis personagens conhecidos como heróis, cada um com um estilo de jogo único, dividido em três papéis gerais adequados ao seu objetivo.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 51,
          user_id: 50,
          name: "Marvel Rivals",
          description:
              "Marvel Rivals é um jogo de tiro PVP baseado em equipes com super-heróis do Universo Marvel, desenvolvido pela Marvel Games e NetEase Games",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 52,
          user_id: 50,
          name: "Stardew Valley",
          description:
              "Stardew Valley é aberto, permitindo aos jogadores cultivar, criar gado, pescar, cozinhar, minerar, forragear e socializar com os habitantes da cidade, incluindo a capacidade de casar e ter filhos.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 53,
          user_id: 50,
          name: "Elden Ring",
          description:
              "Uma aventura de RPG de ação e fantasia ambientada em um mundo criado por Hidetaka Miyazak e George R. R. Martin. O perigo e a descoberta estão à espreita em cada canto do maior jogo da FromSoftware até hoje.",
          release_date: "15/07/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 54,
          user_id: 50,
          name: "Baldur's gate 3",
          description:
              "Reúna seu grupo e volte aos Reinos Esquecidos em uma história de amizade e traição, sacrifício e sobrevivência, e tentação pelo poder absoluto. Habilidades misteriosas despertam em você, semeadas por um parasita devorador de mentes no seu cérebro.",
          release_date: "15/07/2024"));
    }

    jogos = await ctrlJogos.getTodosJogos();

    setState(() {
      searchGames = jogos; // Inicializa a lista de jogos para o filtro
      filteredGames = jogos; // Inicializa a lista filtrada
    });

    return jogos;
  }

  void runFilter(String pesquisa) {
    List<Jogo> resposta = [];
    if (pesquisa.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      resposta = searchGames;
    } else {
      resposta = searchGames
          .where((user) =>
              user.name!.toLowerCase().contains(pesquisa.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    setState(() {
      filteredGames = resposta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todos os Jogos"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, MeusJogos.rota);
                },
                icon: const Icon(Icons.video_collection_outlined)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Login.rota);
                },
                icon: const Icon(Icons.logout_sharp))
          ],
        ),
        /*drawer: const Drawer(
          child: Column(
            children: [
              Text("Teste Drawer"),
              Text("Botão para Meus Jogos"),
              Text("Botão para Sair"),
            ],
          ),
          backgroundColor: Colors.amber,
        ),*/
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
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text("Lista de Jogos"),
                      TextField(
                        onChanged: (value) => runFilter(value),
                        decoration: const InputDecoration(
                            labelText: 'Pesquisar',
                            suffixIcon: Icon(Icons.search)),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: filteredGames.length,
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
                                onTap: () {
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageJogo(filteredGames[index]),
                                    ),
                                  );*/
                                  //Navigator.pushNamed(context, MeusJogos.rota);*/
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(5),
                                  //width: itemWidth,
                                  //height: itemHeight,
                                  child: Center(
                                    child: Text(filteredGames[index].name ??
                                        'Sem nome'),
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
            }));
  }
}
