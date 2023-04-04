import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassA extends StatefulWidget {
  @override
  _ClassAState createState() => _ClassAState();
}

class _ClassAState extends State<ClassA> {
  List<String> _miLista = [];
  Map<String, int> _contador = {};

  @override
  void initState() {
    super.initState();
    _cargarListaDesdeSharedPrefs();
  }

  Future<void> _cargarListaDesdeSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? listaGuardada = prefs.getStringList('miLista');
    if (listaGuardada != null) {
      setState(() {
        _miLista = listaGuardada;
        _contador = _contarElementos(_miLista);
      });
    }
  }

  Future<void> _guardarListaEnSharedPrefs(List<String> lista) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('miLista', lista);
  }

  Map<String, int> _contarElementos(List<String> lista) {
    Map<String, int> contador = {};
    lista.forEach((elemento) {
      contador[elemento] = (contador[elemento] ?? 0) + 1;
    });
    return contador;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _contador.length,
      itemBuilder: (BuildContext context, int index) {
        String elementoActual = _contador.keys.elementAt(index);
        int cantidad = _contador[elementoActual] ?? 0;
        return ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(elementoActual),
              ),
              Text(cantidad.toString()),
            ],
          ),
        );
      },
    );
  }
}
