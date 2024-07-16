/*import 'package:flutter/material.dart';
import 'package:game_tracker_app/Jogo.dart';

class AdicionarResenha extends StatefulWidget {
  static const String rota = "/adicionarResenha";

  @override
  State<AdicionarResenha> createState() => _AdicionarResenhaState();
}

class _AdicionarResenhaState extends State<AdicionarResenha> {

  @override
  void initState() {
    super.initState();
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
                                            
                                            //Adicionar rota e ter que colocar as reviews
                                            SizedBox(
                                            width: 200,
                                            child: ElevatedButton(
                                            onPressed: () => Navigator.pushNamed(context, .rota),
                                            child: Text("SALVAR")),
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
*/