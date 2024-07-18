import 'package:flutter/material.dart';
import 'package:game_tracker_app/paginas/todosJogos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Usuario.dart';
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
                      child: GridView.builder(
                        itemCount: snapshot.data!.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: nJogosRows,
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
                            child: Column(


                              children: [
                                if(index < snapshot.data!.length)
                                  MouseRegion(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PageJogo(snapshot.data![index]),
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
                                        child: 
                                        
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.all(3),
                                          child: Column(
                                            
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                      bottomLeft: Radius.zero,
                                                      bottomRight: Radius.zero),
                                                  child: Image.asset(
                                                    'lib/assets/${snapshot.data![index].id}.png',
                                                    fit: BoxFit.cover,
                                                  )),
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    snapshot.data![index].name ??
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
                                if(index == snapshot.data!.length)







                                  MouseRegion(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AdicionarJogo(),
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
                                        child: 
                                        
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          margin: EdgeInsets.all(3),
                                          child: const Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10),
                                                    bottomLeft: Radius.zero,
                                                    bottomRight: Radius.zero),
                                                child: Icon(Icons.logout_sharp)
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                        'Adicionar Jogo',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  



                                
                              ]
                            )
                            
                            
                            
                            
                            
                            






                          );
                        },
                      ));
                })));
  }
}
