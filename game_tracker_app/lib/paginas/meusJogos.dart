import 'package:flutter/material.dart';
import 'package:game_tracker_app/paginas/todosJogos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/paginas/home.dart';
import 'package:game_tracker_app/paginas/pageJogo.dart';
import 'package:game_tracker_app/paginas/adicionarJogo.dart';

class MeusJogos extends StatefulWidget {
  String usuario;
  static const String rota = "/meusJogos";

  MeusJogos(this.usuario);

  @override
  State<MeusJogos> createState() => _MeusJogosState();
}

class _MeusJogosState extends State<MeusJogos> {

  
  Future<List<Jogo>> getListaJogosUsuario() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();
    int id = preferencias.getInt('id')!;
    widget.usuario = preferencias.getString("apelido")!;
    ControladorJogos ctrlJogos = ControladorJogos();

    setState(() {});

    return ctrlJogos.getJogosUsuario(id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int nJogosRows = 5;
    if (screenWidth < 1000) {
      nJogosRows = 4;
    }
    if (screenWidth < 875) {
      nJogosRows = 3;
    }
    if (screenWidth < 750) {
      nJogosRows = 2;
    }
    if (screenWidth <= 625) {
      nJogosRows = 1;
    }

    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Meus Jogos - ${widget.usuario}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
              backgroundColor: Colors.amber,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, TodosJogos.rota);
                    },
                    icon: const Icon(Icons.video_collection_outlined)),
                IconButton(
                    onPressed: () {
                      //deslogar();
                      Navigator.pushNamed(context, Home.rota);
                    },
                    icon: const Icon(Icons.logout_sharp))
              ],
            ),
            body: FutureBuilder(
                future: getListaJogosUsuario(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: GridView.count(
                      crossAxisCount: nJogosRows,
                      children: List.generate(
                        snapshot.data!.length + 1,
                        (index) => (
                          index < snapshot.data!.length
                          
                          ? Card(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            color: Colors.amber,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PageJogo(snapshot.data![index]),
                                      ),
                                    );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  margin: EdgeInsets.all(3),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        child: Image.asset(
                                          width: 225.0,

                                          'lib/assets/${snapshot.data![index].id}.png',
                                          fit: BoxFit.fitWidth,
                                        )),
                                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Center(child: Text(
                                          snapshot.data![index].name,
                                          textAlign: TextAlign.center,
                                          
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(50, 25, 10, 1)
                                          ),
                                        ))
                                      )
                                    
                                  ]),
                                ),
                              ),
                          )
                          : Card(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Color.fromRGBO(255, 245, 210, 1),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AdicionarJogo.rota);
                                },
                                child: Center(child: const Icon(Icons.add, size: 200, color: Color.fromRGBO(50, 25, 10, 1))),
                              ),
                          )
                          
                        ),
                      ),
                    )
                  );
                })));
  }
}
