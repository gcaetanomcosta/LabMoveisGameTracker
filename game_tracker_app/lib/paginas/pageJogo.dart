import 'package:flutter/material.dart';
import 'package:game_tracker_app/Jogo.dart';

class PageJogo extends StatefulWidget {
 
  Jogo jogoSelecionado;
  
  PageJogo(this.jogoSelecionado); 

  @override
  State<PageJogo> createState() => _PageJogoState();
}

class _PageJogoState extends State<PageJogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.jogoSelecionado.name!),
            backgroundColor: Colors.amber,
        ),
        body: SafeArea(
            child: Column(
                children: [ 
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Image.asset(
                                    'lib/assets/Key-bro.png', 
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                ),
                                Container(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget> [
                                            //Nome do Jogo
                                            Text(
                                                "${widget.jogoSelecionado.name}", 
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.purple,
                                                ),
                                            ),
                                            
                                            SizedBox(height: 30),
                                        
                                            //Data 
                                            Text(
                                                "Data de Lançamento: ${widget.jogoSelecionado.release_date}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[800],
                                                ),
                                            ),

                                            SizedBox(height: 25),
                                            //Descrição
                                            Text(
                                                "${widget.jogoSelecionado.description}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800],
                                                ),
                                            ),

                                            Row(
                                                children: <Widget>[
                                                    //Trocar por nota media
                                                    Text(
                                                        "Nota Média: ${widget.jogoSelecionado.name}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey[800],
                                                        ),
                                                    ),
                                                
                                                ],
                                            ),
                                        ],
                                    ),
                                ),

                            ],

                        ),
                    ),

                   SizedBox(height: 10),
                    //Futuro botão de adicionar review e adicionar rota
                    /*SizedBox(
                        width: 200,
                        child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, .rota),
                        child: Text("Adicionar Review")),
                    ),*/

                    SizedBox(height: 30),

                    //Adicionar reviews recentes somente SE ----------------------------------------- tiver reviews, pra comecar
                    Text(
                        "REVIEWS RECENTES",
                        style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                        ),
                    ),

                    //Usando modelo do alerta dengue Lista de reviews
                    /*
                    Expanded(
                        flex: 2,
                        child: ListView.builder(
                            itemCount: reviews!.length,
                            itemBuilder: (context, index) {
                                Review reviews = reviews[index];
                                //dynamic SE = review.SE;

                                return Card(
                                    child: ListTile(
                                    title: Text('Semana $SE'),
                                    subtitle: Text(
                                        'Usuário: $ca\n Nota: $casos_est \n Descrição: $level \n'),
                                    isThreeLine: true,
                                    ),
                                );
                            }
                        )
                    );*/


                ],


            )
        )
    );
  }
}