import 'package:flutter/material.dart';
import 'package:game_tracker_app/controladores/ControladorUsuario.dart';
import 'package:game_tracker_app/paginas/meusJogos.dart';
import 'package:game_tracker_app/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:sqflite/sqflite.dart";

enum LoginStatus { notSignIn, signIn }

class Login extends StatefulWidget {
  static const String rota = "/login";
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  String? _apelido, _senha;

  final _formKey = GlobalKey<FormState>();
  late ControladorLogin controlador;
  var value;

  _Login() {
    this.controlador = ControladorLogin();
  }

  void _fazerLogin() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();

      try {
        Usuario usuario = await controlador.getLogin(_apelido!, _senha!);

        if (usuario.id != -1) {
          setPref(1, usuario.name, usuario.email, usuario.password, usuario.id);
          _loginStatus = LoginStatus.signIn;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuário não está cadastrado.")));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  getPref() async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    setState(() {
      value = preferencias.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  setPref(int value, String apelido, String email, String senha, int id) async {
    SharedPreferences preferencias = await SharedPreferences.getInstance();

    print(value);
    print(apelido);
    print(email);
    print(senha);
    print(id);
    final databasePath = await getDatabasesPath();
    print(databasePath);


    setState(() {
      preferencias.setInt("value", value);
      preferencias.setString("apelido", apelido);
      preferencias.setString("email", email);
      preferencias.setString("senha", senha);
      preferencias.setInt("id", id);
    });
  }

  @override
  void initState() {
    
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          appBar: AppBar(
            title: Text("Game Tracker"),
            backgroundColor: Colors.amber,
          ),
          body: SafeArea(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('lib/assets/Key-bro.png',
                          width: 250, height: 400),
                    ),

                    //caso usem um icon ao inves da imagem
                    //const Icon(
                    //  Icons.lock_outline_rounded,
                    //  size: 300,
                    //),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                        width: 500.0,
                        height: 50,
                        child: TextFormField(
                          onSaved: (newValue) => _apelido = newValue,
                          obscureText: false,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: 'Nome de Usuário',
                              hintStyle: TextStyle(color: Colors.grey[500])),
                        )),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 500.0,
                      height: 50,
                      child: TextFormField(
                        onSaved: (newValue) => _senha = newValue,
                        obscureText: true,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'Senha',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: _fazerLogin, child: Text("Entrar"))
                  ],
                ),
              ),
            ),
          ),
        );
      case LoginStatus.signIn:
      
        return MeusJogos(_apelido.toString());
    }
  }
}
