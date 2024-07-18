import 'package:flutter/material.dart';
import 'dart:math';
import 'package:game_tracker_app/Jogo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:game_tracker_app/controladores/ControladorJogos.dart';

class AdicionarJogo extends StatefulWidget {
  static const String rota = "/adicionarJogo";

  AdicionarJogo();

  @override
  State<AdicionarJogo> createState() => _AdicionarJogoState();
}

class _AdicionarJogoState extends State<AdicionarJogo> {
  String? _descricao, _titulo;
  TextEditingController _dataLancamentoController =  TextEditingController();

  ControladorJogos ctrlJogos = ControladorJogos();

  final _formKey = GlobalKey<FormState>();

  Future<int> getIdUsuario() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    return preferencias.getInt("id")!;
  }

  void _enviar() async {
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();

      int userID = await getIdUsuario();

      try {
        Jogo jogo = Jogo(
            id: Random().nextInt(2000000000),
            user_id: userID,
            name: _titulo,
            description: _descricao!,
            release_date: _dataLancamentoController.text);
        await ctrlJogos.cadastrarJogo(jogo);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Jogo salvo com sucesso!')));
        Navigator.of(context).pop(); // Navega de volta para a tela anterior
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Erro ao salvar o jogo: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Jogo"),
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
                      onSaved: (newValue) => _titulo = newValue,
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

                  


                  SizedBox(height: 30),

                  TextField(
                    controller: _dataLancamentoController,
                    decoration: InputDecoration(
                      labelText: 'Data de Lançamento',
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none
                      ),
                    ),
                    readOnly: true,
                    onTap: (){
                      _selectDataLancamento();
                    }
                  ),

                  SizedBox(height: 30), 
                    
                  //Adicionar rota e ter que validar o salvamento da review
                  ElevatedButton(
                      onPressed: _enviar, child: Text("SALVAR")),
                ])),
          )),
    );
  }

  Future<void> _selectDataLancamento() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1971),
      lastDate: DateTime(2030)
    );
    if (_picked != null){

      
      setState((){
        _dataLancamentoController.text = _picked.toString().split(" ")[0];
      });
    }
  }

}
