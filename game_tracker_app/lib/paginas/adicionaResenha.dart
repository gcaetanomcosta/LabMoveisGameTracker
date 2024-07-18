import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:game_tracker_app/Jogo.dart';
import 'package:game_tracker_app/Review.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/Jogo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';
import 'package:game_tracker_app/controladores/ControladorReview.dart';

class AdicionaResenha extends StatefulWidget {
  static const String rota = "/adicionaResenha";

  Jogo jogoSelecionado;

  AdicionaResenha(this.jogoSelecionado);

  @override
  State<AdicionaResenha> createState() => _AdicionaResenhaState();
}

class _AdicionaResenhaState extends State<AdicionaResenha> {
  String? _score, _descricao;
  ControladorReview controlador = ControladorReview();

  final _formKey = GlobalKey<FormState>();

  Future<int?> estaLogado() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    return preferencias.getInt("id");
  }

  /*void _enviar() async {

        final form = _formKey.currentState;        
        ControladorReview resenhaEnvio = ControladorReview();
                
        //Algumas variaveis
        int game_id = widget.jogoSelecionado.id;
        double nF = double.parse(_score!);
        dynamic userID = await estaLogado();
        if (userID == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Você deve estar logado para enviar uma resenha.')));
          return;
        }
                
        //Configuracao da data
        final now = new DateTime.now();
        String dataFormatada = DateFormat('yMd').format(now);

        if (form!.validate()) {
            form.save();

            try {
                Review resenha = Review(id: Random().nextInt(2000000000), user_id: userID, game_id: game_id , score: nF , description: _descricao!, date: dataFormatada!);
                resenhaEnvio.adicionarReview(resenha);
            } 
            
            catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
            }
        }
    }*/

  void _enviar() async {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();

      int game_id = widget.jogoSelecionado.id;

      /*if (_score == null || _descricao == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Por favor, preencha todos os campos.')));
        return;
      }*/

      double nF;
      try {
        nF = double.parse(_score!);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('A nota deve ser um número válido.')));
        return;
      }

      int? userID = await estaLogado();
      if (userID == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Você deve estar logado para enviar uma resenha.')));
        return;
      }

      final now = DateTime.now();
      String dataFormatada = DateFormat('yMd').format(now);

      try {
        Review resenha = Review(
            id: Random().nextInt(2000000000),
            user_id: userID,
            game_id: game_id,
            score: nF,
            description: _descricao!,
            date: dataFormatada);
        await controlador.adicionarReview(resenha);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Resenha salva com sucesso!')));
        Navigator.of(context).pop(); // Navega de volta para a tela anterior
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Erro ao salvar a resenha: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Resenha"),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onSaved: (newValue) => _score = newValue,
                      obscureText: false,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Nota',
                          hintStyle:
                              TextStyle(color: Colors.grey[500])),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por Favor, Insira uma nota";
                        }
                        return null;
                      },
                    ),
                    
                  SizedBox(height: 30),
                    
                  TextFormField(
                    onSaved: (newValue) => _descricao = newValue,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Descricao',
                        hintStyle:
                            TextStyle(color: Colors.grey[500])),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por Favor, Insira uma Descrição";
                      }
                      return null;
                    },
                  ),
                    
                  SizedBox(height: 30),
                    
                  //Adicionar rota e ter que validar o salvamento da review
                  ElevatedButton(
                      onPressed: _enviar, child: Text("SALVAR")),
                ])),
          )),
    );
  }
}
