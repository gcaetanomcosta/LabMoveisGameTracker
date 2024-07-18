// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:game_tracker_app/Genero.dart';
import 'package:game_tracker_app/JogoGenero.dart';
import 'package:game_tracker_app/controladores/ControladorGenero.dart';
import 'package:game_tracker_app/controladores/ControladorJogoGenero.dart';
import 'package:game_tracker_app/paginas/home.dart';
import 'package:game_tracker_app/paginas/login.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/paginas/pageJogo.dart';
import 'package:game_tracker_app/paginas/reviewsRecentes.dart';
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
  ControladorGenero ctrlGeneros = ControladorGenero();
  ControladorJogoGenero ctrlJogoGenero = ControladorJogoGenero();

  DatabaseHelper dbHelper = DatabaseHelper();

  late Future<List<Jogo>> allGames;
  late Future<List<Genero>> allGenres;

  List<Jogo> searchGames = [];
  List<Jogo> filteredGames = [];

  List<Genero> searchGenres = [];
  String? selectedGenre;

  List<JogoGenero> allAssociacoes = [];

  int linhaJOgos = 3;

  late LoginStatus _loginStatus = LoginStatus.notSignIn;

  late int? idDoUsuario;

  String _searchText = "";

  @override
  void initState() {
    super.initState();

    estaLogado();

    allGenres = inicializarTodosGeneros();

    allGames = incicializarTodosJogos();

    associarJogoGenero();
  }

  void estaLogado() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    int? usuarioId = preferencias.getInt("id");

    idDoUsuario = usuarioId;

    setState(() {
      _loginStatus = usuarioId == null || usuarioId == -1
          ? LoginStatus.notSignIn
          : LoginStatus.signIn;
    });
  }

  Future<List<Jogo>> incicializarTodosJogos() async {
    List<Jogo> jogos = await ctrlJogos.getTodosJogos();

    if (jogos.isEmpty) {
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 41,
          user_id: 1080303952,
          name: "Zelda: Tears of The Kingdom",
          description:
              "Embarque em uma busca épica para salvar o reino de Hyrule. Adquira novas habilidades, use a icônica Master Sword além de itens especiais, que ajudam a superar obstáculos e derrotar inimigos.",
          release_date: "12/05/2023"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 42,
          user_id: 1080303952,
          name: "Super Mario Odissey",
          description:
              "Explore lugares incríveis longe do Reino Cogumelo com o Mario e o novo aliado Cappy em uma imensa aventura 3D ao redor do mundo.",
          release_date: "27/10/2017"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 43,
          user_id: 1080303952,
          name: "Luigi's Mansion 3",
          description:
              "Luigi deve explorar um hotel assombrado, incorporando temáticas diferentes em cada andar, e resgatar seus amigos dos fantasmas que o habitam.",
          release_date: "31/10/2019"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 44,
          user_id: 1080303952,
          name: "Pokémon Violet",
          description:
              "Capture, lute e treine Pokémon na região de Paldea, uma vasta área cheia de lagos, picos imponentes, desertos, vilarejos e cidades em expansão. Explore o mundo aberto montado no Pokémon lendário que muda de forma",
          release_date: "18/11/2022"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 45,
          user_id: 1080303952,
          name: "Pokémon: Let's Go, Pikachu!",
          description:
              "Capture e colecione Pokémon em uma aventura diversa e vibrante no jogo Pokémon™: Torne-se o melhor Treinador de Pokémon que puder, enquanto batalha outros Treinadores, Líderes de Ginásios e a sinistra Equipe Rocket.",
          release_date: "16/11/2018"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 46,
          user_id: 1080303952,
          name: "League of Legends",
          description:
              "Jogo de estratégia onde duas equipes de cinco campeões se enfrentam para destruir a base adversária. Escolha entre mais de 140 campeões para fazer jogadas épicas, garantir mortes e derrubar torres enquanto luta para chegar à vitória.",
          release_date: "27/11/2009"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 47,
          user_id: 1080303952,
          name: "DOTA",
          description:
              "Jogo de equipe competitivo com elementos de RPG. Duas equipes rivais (Iluminados e Temidos) com cinco jogadores cada. O objetivo principal é destruir o Ancestral inimigo dentro de sua fortaleza.",
          release_date: "09/07/2013"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 48,
          user_id: 1080303952,
          name: "Hades",
          description:
              "Hades é um RPG de ação e exploração de masmorras rogue-like. Utilize o poder de armas míticas do Olimpo para escapar das garras do deus da morte, ficando cada vez mais forte a cada nova tentativa de fuga.",
          release_date: "06/12/2018"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 49,
          user_id: 50,
          name: "Hades 2",
          description:
              "No papel da princesa do Submundo, explore um mundo mitológico mais amplo e instigante enquanto subjuga as forças do titã do tempo com todo o poder do Olimpo ao seu lado em uma história arrebatadora.",
          release_date: "06/05/2024"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 50,
          user_id: 50,
          name: "Overwacth",
          description:
              "Como um hero shooter, Overwatch designa jogadores em dois times de seis personagens conhecidos como heróis, cada um com um estilo de jogo único, dividido em três papéis gerais adequados ao seu objetivo.",
          release_date: "03/05/2016"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 51,
          user_id: 50,
          name: "Marvel Rivals",
          description:
              "Marvel Rivals é um jogo de tiro PVP baseado em equipes com super-heróis do Universo Marvel, desenvolvido pela Marvel Games e NetEase Games",
          release_date: "30/2/2026"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 52,
          user_id: 50,
          name: "Stardew Valley",
          description:
              "Stardew Valley é aberto, permitindo aos jogadores cultivar, criar gado, pescar, cozinhar, minerar, forragear e socializar com os habitantes da cidade, incluindo a capacidade de casar e ter filhos.",
          release_date: "26/02/2016"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 53,
          user_id: 50,
          name: "Elden Ring",
          description:
              "Uma aventura de RPG de ação e fantasia ambientada em um mundo criado por Hidetaka Miyazak e George R. R. Martin. O perigo e a descoberta estão à espreita em cada canto do maior jogo da FromSoftware até hoje.",
          release_date: "25/02/2022"));
      await ctrlJogos.cadastrarJogo(Jogo(
          id: 54,
          user_id: 50,
          name: "Baldur's gate 3",
          description:
              "Reúna seu grupo e volte aos Reinos Esquecidos em uma história de amizade e traição, sacrifício e sobrevivência, e tentação pelo poder absoluto. Habilidades misteriosas despertam em você, semeadas por um parasita devorador de mentes no seu cérebro.",
          release_date: "03/08/2023"));
    }

    jogos = await ctrlJogos.getTodosJogos();

    setState(() {
      searchGames = jogos;
      filteredGames = jogos;
    });

    return jogos;
  }

  Future<List<Genero>> inicializarTodosGeneros() async {
    List<Genero> generos = await ctrlGeneros.getTodosGeneros();

    if (generos.isEmpty) {
      await ctrlGeneros.cadastrarGenero(Genero(id: 1, name: "Moba"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 2, name: "RPG"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 3, name: "Souls-Like"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 4, name: "Simulação"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 5, name: "Hero-Shooter"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 6, name: "RogueLike"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 7, name: "Plataforma"));
      await ctrlGeneros.cadastrarGenero(Genero(id: 8, name: "Acão-Aventura"));
    }

    generos = await ctrlGeneros.getTodosGeneros();

    setState(() {
      searchGenres = generos;
    });

    return generos;
  }

  void associarJogoGenero() async {
    List<JogoGenero> associacoes = await ctrlJogoGenero.getTodasAssociacoes();
    if (associacoes.isEmpty) {
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(41));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(42));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(43));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(44));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(45));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(46));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(47));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(48));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(49));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(50));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(51));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(52));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(53));
      await ctrlJogoGenero.associarJogoGenero(
          await ctrlGeneros.getGeneroID(2), await ctrlJogos.getJogoID(54));
    }

    associacoes = await ctrlJogoGenero.getTodasAssociacoes();

    setState(() {
      allAssociacoes = associacoes;
    });

    runFilter();
  }

  void runFilter() {
    List<Jogo> resposta = [];
    if (selectedGenre == null) {
      resposta = searchGames;
    } else {
      /*resposta = searchGames
          .where((user) =>
              user.name!.toLowerCase().contains(pesquisa.toLowerCase()))
          .toList();*/
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
            if (_loginStatus == LoginStatus.signIn) ...[
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MeusJogos.rota);
                  },
                  icon: const Icon(Icons.account_circle)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Home.rota);
                  },
                  icon: const Icon(Icons.logout_sharp))
            ] else ...[
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Home.rota);
                  },
                  icon: const Icon(Icons.vpn_key)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ReviewsRecentes.rota);
                  },
                  icon: const Icon(Icons.punch_clock))
            ]
          ],
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
                return Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: TextField(
                              onChanged: (value) => runFilter(),
                              decoration: InputDecoration(
                                labelText: 'Pesquisar',
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: FutureBuilder<List<Genero>>(
                                future: allGenres,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Text('Nenhum gênero encontrado.');
                                  } else {
                                    return DropdownButtonFormField(
                                      //padding: EdgeInsets.symmetric(vertical: 15),
                                      value: selectedGenre,
                                      hint: Text("Gêneros"),
                                      items: searchGenres.map((Genero genero) {
                                        return DropdownMenuItem<String>(
                                          value: genero.name,
                                          child: Text(genero.name!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGenre = value;
                                          runFilter();
                                        });
                                      },
                                      decoration: InputDecoration(
                                          //contentPadding: Edge
                                          ),
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: GridView.builder(
                          itemCount: filteredGames.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: linhaJOgos,
                            childAspectRatio: 1 / 1.7,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.amber,
                              margin: EdgeInsets.all(5),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MouseRegion(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PageJogo(filteredGames[index]),
                                      ),
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          /*BoxShadow(
                                          //color: _isHovering,
                                          spreadRadius: 
                                        )*/
                                        ]),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(3),
                                      child: Column(children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.zero,
                                                bottomRight: Radius.zero),
                                            child: Image.asset(
                                              'lib/assets/${filteredGames[index].id}.png',
                                              fit: BoxFit.cover,
                                            )),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              filteredGames[index].name ??
                                                  'Sem nome',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
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
