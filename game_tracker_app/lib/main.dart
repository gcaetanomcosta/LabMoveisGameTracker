import 'package:flutter/material.dart';
import 'package:game_tracker_app/paginas/home.dart';
import 'package:game_tracker_app/paginas/cadastro.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/paginas/login.dart';
import 'package:game_tracker_app/paginas/reviewsRecentes.dart';
import 'package:game_tracker_app/paginas/todosJogos.dart';
import 'package:game_tracker_app/helper/DatabaseHelper.dart';
import 'package:game_tracker_app/paginas/adicionarJogo.dart';


void main() async {
  //String databasePath = await getDatabasesPath();
  //print(databasePath);
  //await databaseFactory.deleteDatabase(databasePath);

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await DatabaseHelper().db;
  } catch (e) {
    print('Erro ao inicializar o banco de dados: $e');
    // Você pode adicionar lógica para lidar com o erro, como exibir uma mensagem ou encerrar o aplicativo
  }
  runApp(MaterialApp(
    title: "Game Tracker",
    debugShowCheckedModeBanner: false,
    home: Home(),
    routes: {
      Login.rota: (context) => Login(),
      Cadastro.rota: (context) => Cadastro(),
      MeusJogos.rota: (context) => MeusJogos('visitante'),
      TodosJogos.rota: (context) => TodosJogos(),
      Home.rota: (context) => Home(),
      ReviewsRecentes.rota: (context) => ReviewsRecentes(),
      AdicionarJogo.rota: (context) => AdicionarJogo()
    },
  ));
}









//CODIGO PARA DELETAR BANCO DE DADOS
/*
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final dbHelper = DatabaseHelper();
    await dbHelper.deletarDatabase();
    await DatabaseHelper().db;
  } catch (e) {
    print('Erro ao inicializar o banco de dados: $e');
    // Você pode adicionar lógica para lidar com o erro, como exibir uma mensagem ou encerrar o aplicativo
  }
*/
