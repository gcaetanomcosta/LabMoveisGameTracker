import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeusJogos extends StatefulWidget{
  const MeusJogos({super.key});

  @override
  State<MeusJogos> createState() => _MeusJogosState(); 
}

class _MeusJogosState extends State<MeusJogos> {
  //String? _jogo;
  int nJogos = 7;


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
          title: const Center(
            child: Text(
              "Meus Jogos",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24
              )  
            )
          ),
          backgroundColor: Color.fromRGBO(175, 175, 50, 1.0),
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