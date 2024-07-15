import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Usuario.dart';


class MeusJogos extends StatefulWidget{
  String usuario;
  static const String rota = "/meusJogos";

  MeusJogos(this.usuario);

  @override
  State<MeusJogos> createState() => _MeusJogosState(); 
}

class _MeusJogosState extends State<MeusJogos> {
  ControladorJogos ctrlJogos = ControladorJogos();
  
  Future<int> getIdUsuario() async{
    SharedPreferences preferencias = await SharedPreferences.getInstance();
    int id = preferencias.getInt('id')!;
    return id;
  }



    try {

      List<Jogo> listaJogosUsuario = await ctrlJogos.getJogosUsuario(id);

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    
    
  
  
  }


  int nJogos = (await ctrlJogos.getJogosUsuario(await getIdUsuario())).length;



  //List<Jogo> listaJogosUsuario = await ctrlJogos.getJogosUsuario('');
  //int nJogos = 7;

  @override
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    int nJogosRows = 5;
    if (screenWidth < 1000){
      nJogosRows = 4;
    }
    if(screenWidth < 875){
      nJogosRows = 3;
    }
    if(screenWidth < 750){
      nJogosRows = 2;
    }
    if(screenWidth <= 625){
      nJogosRows = 1;
    }

    return Container(
      
      child: Scaffold(
        appBar: AppBar(
          title:  Center(
            child: Text(
              'Game Tracker APP - Meus Jogos de ${widget.usuario}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24
              )  
            )
          ),
          backgroundColor: Colors.amber,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: GridView.count(
            crossAxisCount: nJogosRows,
            children: List.generate(
              nJogos,
              (index) => Card(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.black,
                child: Center(child: Text('Item $index')),
              ),
            ),
          )
        )
      )
    );
  }
}