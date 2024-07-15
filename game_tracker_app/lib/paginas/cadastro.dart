import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_tracker_app/controladores/ControladorUsuario.dart';
import 'package:game_tracker_app/paginas/login.dart';
import 'package:game_tracker_app/Usuario.dart';


class Cadastro extends StatefulWidget {
  static const rota = "/cadastro";
  State<Cadastro> createState() => _Cadastro();
}

class _Cadastro extends State<Cadastro> {
  String? _apelido, _email, _senha, _senha2;
  ControladorLogin controlador = ControladorLogin();

  final _formKey = GlobalKey<FormState>();

  void _enviar() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        int apelidoJaEscolhido =
            await controlador.getApelidoEscolhido(_apelido!);
        Usuario usuario =
            Usuario(name: _apelido!, email: _email!, password: _senha!, id: Random().nextInt(2000000000));

        if (apelidoJaEscolhido == 0) {
          if (_senha == _senha2) {
            controlador.cadastrarUsuario(usuario);
            Navigator.pushNamed(context, Login.rota);
          } else
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("As senhas não combinam.")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Este apelido já foi escolhido.")));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Tracker"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Image.asset('lib/assets/register.png',
                    width: 250, height: 400),
              ),
              Text(
                "Cadastro",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                onSaved: (newValue) => _apelido = newValue,
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
                    hintText: 'Nome de Usuário',
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 500.0,
                height: 50,
                child: TextFormField(
                  onSaved: (newValue) => _email = newValue,
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
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 500.0,
                height: 50,
                child: TextFormField(
                  onSaved: (newValue) => _senha = newValue,
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
                      hintText: 'Senha',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 500.0,
                height: 50,
                child: TextFormField(
                  onSaved: (newValue) => _senha2 = newValue,
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
                      hintText: 'Confirme a senha',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(onPressed: _enviar, child: Text("Cadastrar"))
            ],
          ),
        ),
      ),
    );
  }
}
