import 'package:flutter/material.dart';
import 'package:game_tracker_app/controladores/ControladorReview.dart';
import 'package:game_tracker_app/Review.dart';

class ReviewsRecentes extends StatefulWidget {
  static const String rota = "/reviewsRecentes";

  @override
  State<ReviewsRecentes> createState() => _ReviewsRecentes();
}

class _ReviewsRecentes extends State<ReviewsRecentes> {
  ControladorReview ctrlReview = ControladorReview();
  late Future<List<Review>> reviewsRecentes = ctrlReview.getReviewsRecentes();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews Recentes',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<Review>>(
          future: reviewsRecentes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Não há nenhuma review recente.'));
            } else {
              return Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: ctrlReview.getReviewsRecentes(),
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
                                List<Review>? resenhas =
                                    snapshot.data?.cast<Review>();
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
                                              title:
                                                  Text('Resenha $resenha_id'),
                                              subtitle: Text(
                                                  'User: $user_id.\n Nota: $score \n Descrição: $descr \n'),
                                              isThreeLine: true,
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              }
                          }

                          return Text("Erro ao carregar");
                        })
                  ],
                ),
              );
            }
          }),
    );
  }
}
