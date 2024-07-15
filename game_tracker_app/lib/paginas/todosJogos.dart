import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodosJogos extends StatefulWidget {
  static const String rota = "/todosJogos";

  @override
  State<TodosJogos> createState() => _TodosjogosState();
}

class _TodosjogosState extends State<TodosJogos> {
  late SharedPreferences preferencias;

  @override
  void initState() {
    super.initState();

    getPreferences();
  }

  Future<void> getPreferences() async {
    preferencias = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos os Jogos"),
      ),
      body: FutureBuilder(
          future: getPreferences(),
          builder: (Context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar preferências'));
            } else {
              return Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text("teste"),
                    Text(preferencias.getString("apelido") ??
                        "Nenhum apelido definido")
                  ],
                ),
              );
            }
          }),
    );
  }
}
