import 'package:flutter/material.dart';
import 'package:game_tracker_app/paginas/cadastro.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/paginas/todosJogos.dart';
import 'package:game_tracker_app/paginas/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  
  void deslogar() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    // APAGAR DADOS DE APELIDO, EMAIL E SENHA EM "preferencias"
    setState(() {
      preferencias.setInt("value", -1);
      preferencias.setString("apelido", "");
      preferencias.setString("email", "");
      preferencias.setString("senha", "");
      //_loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    deslogar();

    return Scaffold(
      appBar: AppBar(
        title: Text("Game Tracker"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Bem-vindo ao Game Tracker!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Container(
            width: 200,
            height: 200,
            child: Image.asset('lib/assets/game-equipment.png',
                width: 250, height: 400),
          ),
          SizedBox(height: 30),
          Text(
            "Escolha uma opção para prosseguir:",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Login.rota),
                child: Text("Fazer login")),
          ),
          SizedBox(height: 10),
          SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Cadastro.rota),
                  child: Text("Cadatrar"))),
          SizedBox(height: 10),
          SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, TodosJogos.rota),
                  child: Text("Entrar sem cadastro"))
          ),
          
          SizedBox(height: 10),
          
          //SizedBox(
          //    width: 200,
          //    child: ElevatedButton(
          //        onPressed: () {
          //          deslogar();
          //        },
          //        child: Text("Sair"))),
        ],
      )),
    );
  }
}
