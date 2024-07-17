import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Review.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/controladores/ControladorReview.dart';

class AdicionarResenha extends StatefulWidget {
  static const String rota = "/adicionarResenha";

  @override
  State<AdicionarResenha> createState() => _AdicionarResenhaState();
}

class _AdicionarResenhaState extends State<AdicionarResenha> {

    
    String? _nota, _descricao;
    ControladorReview controlador = ControladorReview();
  
    Future<int> getIdUsuario() async{
        SharedPreferences preferencias = await SharedPreferences.getInstance();
        int id = preferencias.getInt('id')!;
        return id;
    }
    //tem que ver como pegar o id do jogo, esse codifo nao eve estar funcionando pro teste
    Future<int> getJogoID() async{
        SharedPreferences preferencias = await SharedPreferences.getInstance();
        int id = preferencias.getInt('id')!;
        return id;
    }

  final _formKey = GlobalKey<FormState>();

  void _enviar() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        double notaFinal = double.parse($_nota); 
        final now = new DateTime.now();
        String dataFormatada = DateFormat('yMd').format(now);

        Review resenha =
            Review(id: Random.nextInt(2000000000), user_id: getIdUsuario(), game_id:/*----------------------*/ */, score: notaFinal! , description: comentario!, date: dataFormatada!);

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Resenha"),
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
                                
                                Container(
                                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget> [
                                            //Nome do Jogo
                                           SizedBox(
                                                width: 500.0,
                                                height: 50,
                                                child: TextFormField(
                                                onSaved: (newValue) => _nota = newValue,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    enabledBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                                    ),
                                                    fillColor: Colors.grey.shade200,
                                                    filled: true,
                                                    hintText: 'Nota',
                                                    hintStyle: TextStyle(color: Colors.grey[500])),
                                                ),
                                            ),
                                            
                                            SizedBox(height: 30),
                                            
                                            SizedBox(
                                                width: 500.0,
                                                height: 50,
                                                child: TextFormField(
                                                onSaved: (newValue) => _descricao = newValue,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    enabledBorder: const OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.grey.shade400),
                                                    ),
                                                    fillColor: Colors.grey.shade200,
                                                    filled: true,
                                                    hintText: 'Descricao',
                                                    hintStyle: TextStyle(color: Colors.grey[500])),
                                                ),
                                            ),
                                            
                                            SizedBox(height: 30),
                                            
                                            //Adicionar rota e ter que validar o salvamento da review
                                            SizedBox(
                                                width: 200,
                                                child: ElevatedButton(
                                                    onPressed: _enviar(),
                                                    child: Text("SALVAR")
                                                ),
                                            ),  
                                        
                                        ],

                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        ),
    );

  }
}
