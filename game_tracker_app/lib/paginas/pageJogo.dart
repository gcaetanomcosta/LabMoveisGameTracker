import 'package:flutter/material.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Review.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/controladores/ControladorReview.dart';


import 'package:game_tracker_app/paginas/adicionarResenha.dart';

class PageJogo extends StatefulWidget {
 
  Jogo jogoSelecionado;
    
  PageJogo(this.jogoSelecionado); 

  @override
  State<PageJogo> createState() => _PageJogoState();
}

class _PageJogoState extends State<PageJogo> {
  Future<List<Review>> getResenhasJogo() async{
    int game_id = widget.jogoSelecionado.id;
    ControladorReview ctrlResenha = ControladorReview();
    return ctrlResenha.getReviewsJogo(game_id);
  }

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
                    //Botao de adicionar review e adicionar rota
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, AdicionarResenha.rota),
                        child: Text("Adicionar Review")
                        ),
                    ),

                    SizedBox(height: 30),

                    //Adicionar reviews recentes somente SE ------------------------------ tiver reviews
                    Text(
                        "REVIEWS RECENTES",
                        style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                        ),
                    ),

                    //Usando modelo do alerta dengue Lista de reviews
                    
                    FutureBuilder(
                        future: getResenhasJogo(),
                        builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                                return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                            case ConnectionState.done:
                                if (snapshot.hasError) {
                                    print("Erro ao carregar");
                                    break;
                                } else {
                                    //List<Review>? resenhas = snapshot.data?.cast<Review>();
                                    dynamic resenhas = getReviewsJogo();

                                    return Expanded(
                                        flex: 2,
                                        child: ListView.builder(
                                            
                                            itemCount: resenhas!.length,
                                            itemBuilder: (context, index) {
                                                Review review = resenhas[index];
                                                //dynamic num = review.SE;

                                                return Card(
                                                    child: ListTile(
                                                    title: Text('Resenha $review.id'),
                                                    subtitle: Text(
                                                        'User: $review.user_id\n Nota: $ review.score \n Descrição: $review.description \n'),
                                                    isThreeLine: true,
                                                    ),
                                                );
                                            }
                                        )
                                    );
                                }
                           
                            return Text(
                                "Erro ao carregar. Verifique se todos os dados foram preenchidos");
                            });
                        }
                    }
            
        
                ]
            )
        )
    );
  }
}