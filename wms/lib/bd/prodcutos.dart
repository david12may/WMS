import 'package:flutter/material.dart';

import 'database.dart';

class bd extends StatefulWidget {
  bd({Key? key}) : super(key: key);

  @override
  State<bd> createState() => _bdState();
}

class _bdState extends State<bd> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController codigo_barra = TextEditingController(text: "");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 213, 214, 215),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 72, 91, 133),
            elevation: 5,
            centerTitle: true,
            title: Text("Inventario"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(25),
              height: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.transparent,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: codigo_barra,
                    decoration: InputDecoration(labelText: "Clave:"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        String cod = codigo_barra.text;
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (context) {
                          return new conexionHTTP(cod);
                        }));
                      },
                      child: Text("Consultar"))
                ],
              ),
            ),
          )),
    );
  }
}
