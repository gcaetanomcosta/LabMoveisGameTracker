import 'package:flutter/material.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Review.dart';
import 'package:game_tracker_app/controladores/ControladorReview.dart';
import 'package:game_tracker_app/paginas/adicionaResenha.dart';

class PageJogo extends StatefulWidget {
  static const String rota = "/pageJogo";
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

  Future<double?> getMediaResenhas() async{
    int game_id = widget.jogoSelecionado.id;
    ControladorReview ctrlResenha = ControladorReview();
    return ctrlResenha.getMediaReviews(game_id);
  }
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.jogoSelecionado.name!),
            backgroundColor: Colors.amber,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
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
                                      'lib/assets/${widget.jogoSelecionado.id}.png', 
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.fitHeight,
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
                                              //Descricao
                                              Text(
                                                  "${widget.jogoSelecionado.description}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[800],
                                                  ),
                                              ),
                                              
                                              SizedBox(height: 25),
              
                                              Row(
                                                  children: <Widget>[
                                                      //Trocar por nota media das resenhas -------------------------------
                                                      Text(
                                                          "Nota Média: ${getMediaResenhas()}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.grey[800],
                                                          ),
                                                      ),                                                  
                                                    ],
                                              ),
                                              SizedBox(height: 25),
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
                          onPressed: /*() => Navigator.pushNamed(context, AdicionaResenha.rota),*/
                          () async { bool result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdicionaResenha(widget.jogoSelecionado),
                                      ),
                                    );
                                    if(result){
                                      setState(() {
                                        
                                      });
                                    }
                                    },
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
                                      } 
                                     
                                      else {
                                          List<Review>? resenhas = snapshot.data?.cast<Review>();
                                          //dynamic resenhas = getResenhasJogo();
                                          return Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: resenhas!.length,
                                                  itemBuilder: (context, index) {
                                                      Review rev = resenhas[index];
                                                      dynamic user_id = rev.user_id;
                                                      dynamic score = rev.score;
                                                      dynamic descr = rev.description;
                                                      dynamic resenha_id = rev.id;
                                                            
                                                      return Card(
                                                          child: ListTile(
                                                          title: Text('Resenha $resenha_id'),
                                                          subtitle: Text(
                                                              'User: $user_id.\n Nota: $score \n Descrição: $descr \n'),
                                                          isThreeLine: true,
                                                          ),
                                                      );
                                                  }
                                              ),
                                            ],
                                          );     
                                      }
                                  }
                             
                                  return Text(
                                      "Erro ao carregar"
                                  );
                                  
                          }
                      )
                  ]
              ),
            )
        )
    );
  }
}


//Arquivo antes da mudanca para o onRefresh----------------------------------- esse antigo estava funcionando
/*
class PageJogo extends StatefulWidget {
  static const String rota = "/pageJogo";
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
/*
  Future<double?> getMediaResenhas() async{
    int game_id = widget.jogoSelecionado.id;
    ControladorReview ctrlResenha = ControladorReview();
    return ctrlResenha.getMediaReviews(game_id);
  }
  
  void refreshList() {
    // reload
    setState(() {
      updateAndGetList();
    });
  }

  Future<List<Review>> updateAndGetList() async {
    //await widget.feeds.update();

    // return the list here
    return; //widget.feeds.getList();
  }*/
  
  
  
  
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.jogoSelecionado.name!),
            backgroundColor: Colors.amber,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
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
                                      'lib/assets/${widget.jogoSelecionado.id}.png', 
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.fitHeight,
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
                                              //Descricao
                                              Text(
                                                  "${widget.jogoSelecionado.description}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[800],
                                                  ),
                                              ),
                                              
                                              SizedBox(height: 25),
              
                                              Row(
                                                  children: <Widget>[
                                                      //Trocar por nota media das resenhas -------------------------------
                                                      /*Text(
                                                          "Nota Média: ${getMediaResenhas()}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors.grey[800],
                                                          ),
                                                      ),*/
                                                  ],
                                              ),
                                              SizedBox(height: 25),
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
                          onPressed: /*() => Navigator.pushNamed(context, AdicionaResenha.rota),*/
                          () async {bool result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdicionaResenha(widget.jogoSelecionado),
                                      ),
                                    );
                                    if(result){
                                      setState(() {
                                        
                                      });
                                    }
                                    },
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
                                      } 
                                     
                                      else {
                                          List<Review>? resenhas = snapshot.data?.cast<Review>();
                                          //dynamic resenhas = getResenhasJogo();
                                          return Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: resenhas!.length,
                                                  itemBuilder: (context, index) {
                                                      Review rev = resenhas[index];
                                                      dynamic user_id = rev.user_id;
                                                      dynamic score = rev.score;
                                                      dynamic descr = rev.description;
                                                      dynamic resenha_id = rev.id;
                                                            
                                                      return Card(
                                                          child: ListTile(
                                                          title: Text('Resenha $resenha_id'),
                                                          subtitle: Text(
                                                              'User: $user_id.\n Nota: $score \n Descrição: $descr \n'),
                                                          isThreeLine: true,
                                                          ),
                                                      );
                                                      //onRefresh: refreshList,
                                                  }
                                              ),
                                            ],
                                          );     
                                      }
                                  }
                             
                                  return Text(
                                      "Erro ao carregar"
                                  );
                                  
                          }
                      )
                  ]
              ),
            )
        )
    );
  }
}


 */