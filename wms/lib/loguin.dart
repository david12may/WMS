import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms/principal.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Map<String, dynamic>? dataMap;
  Map<String, dynamic>? DoneDataMap;
  var userController = TextEditingController();
  var passwordController = TextEditingController();

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 1, 26, 82),
                Color.fromARGB(255, 0, 32, 65),
              ])),
          child: CircleAvatar(
            child: Image.asset(
              'assets/codigo.png',
              scale: 3,
              width: 300,
            ),
            radius: 100,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -40),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 260, bottom: 20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: userController,
                          decoration: InputDecoration(labelText: "Usuario:"),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(labelText: "Contraseña"),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ButtonBar(children: [
                          ElevatedButton(
                            onPressed: () => _login(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Iniciar Sesión"),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future<void> _login(BuildContext context) async {
    final email = userController.text;
    final password = passwordController.text;

    final response = await http.post(
      Uri.parse("https://dev.soferp.com/app/login?database_id=1"),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      print(DoneDataMap);
      dataMap = jsonDecode(response.body);
      DoneDataMap = dataMap;
      // Token de acceso devuelto por el servidor

      final String uss = DoneDataMap!["usuario"].toString();
      final String api = DoneDataMap!["api_key"].toString();

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Principal(uss, api)));
    } else {
      print("Usuario incorrecto");
      print('Response body: ${response.body}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error de inicio de sesión'),
          content: Text('Las credenciales ingresadas son incorrectas'),
          actions: <Widget>[],
        ),
      );
    }
  }
}
