import 'package:flutter/material.dart';
import 'package:game_tracker_app/paginas/home.dart';
import 'package:game_tracker_app/paginas/cadastro.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/paginas/login.dart';
import 'package:game_tracker_app/paginas/todosJogos.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DatabaseHelper().db;
  } catch (e) {
    print('Erro ao inicializar o banco de dados: $e');
    // Você pode adicionar lógica para lidar com o erro, como exibir uma mensagem ou encerrar o aplicativo
  }
  runApp(
    MaterialApp(
      title: "Game Tracker",
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        Login.rota: (context) => Login(),
        Cadastro.rota: (context) => Cadastro(),
        MeusJogos.rota: (context) => MeusJogos('visitante'),
        TodosJogos.rota: (context) => TodosJogos()
      },
    )
  );
}