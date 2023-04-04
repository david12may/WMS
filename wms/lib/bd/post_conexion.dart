import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms/inventario.dart';

class Enviar extends StatefulWidget {
  String O;
  String a;

  Enviar(this.a, this.O, {Key? key}) : super(key: key);

  @override
  State<Enviar> createState() => _EnviarState();
}

class _EnviarState extends State<Enviar> {
  List<String> _miLista = [];
  Map<String, int> _contador = {};

  Future<void> postData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final myList = prefs.getStringList('miLista');
    List<String>? listaGuardada = prefs.getStringList('miLista');
    Map<String, dynamic> mapa = {'concepto': listaGuardada};

    final dartList = List<String>.from(myList!);
    final mappedList = dartList.map((item) => {'concepto:': item}).toList();

    for (final item in mappedList) {
      final json = jsonEncode(item);
      if (listaGuardada != null) {
        String listaJSON = jsonEncode(listaGuardada);

        final url = Uri.parse(
            'https://dev.soferp.com/app/inventarios_fisicos?api_key=${widget.a}');
        final headers = {'Content-Type': 'application/json'};
        final data = {
          "empresa_id": 70,
          "sucursal_id": 6,
          "almacen_id": 9,
          "fecha": "${widget.O}",
          "tipo_aplicacion": 1,
          "detalles": [
            {
              "concepto": "$mappedList",
              "producto_id": 31,
              "unidad_id": 1,
              "cantidad": 2,
              "costo": 1,
              "total": 2,
              "importe": 1
            }
          ]
        };

        final body = jsonEncode(data);

        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          String a = widget.a;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Inventario(a)));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Los datos fueron enviado correcta mente'),
              backgroundColor: Colors.greenAccent.shade700,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          _borrarD();
          print(mapa);
          print(mappedList);
          print('Datos enviados con éxito');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al emviar los datos'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          String a = widget.a;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Inventario(a)));
          print('Error al enviar datos: ${response.statusCode}');
        }
      }
    }

    // Aquí deberías enviar el JSON a la API utilizando tu método preferido (por ejemplo, usando la biblioteca http)
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

  Map<String, int> _contarElementos(List<String> lista) {
    Map<String, int> contador = {};
    lista.forEach((elemento) {
      contador[elemento] = (contador[elemento] ?? 0) + 1;
    });
    return contador;
  }

  @override
  void initState() {
    super.initState();
    _cargarListaDesdeSharedPrefs();
    postData();
  }

  _en() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? listaGuardada = prefs.getStringList('miLista');

    if (listaGuardada != null) {
      // Convertir la lista en formato JSON
      String listaJSON = jsonEncode(listaGuardada);

      // Crear la solicitud HTTP POST
      var url = Uri.parse('https://miapi.com/miendpoint');
      var headers = {'Content-Type': 'application/json'};
      var body = listaJSON;
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // La solicitud fue exitosa
        print('La lista fue enviada a la API');
      } else {
        // La solicitud falló
        print('Error al enviar la lista a la API');
      }
    }
  }

  _borrarD() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('miLista');
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.transparent,
          child: CupertinoActivityIndicator(
            color: Colors.black,
            radius: 20,
          ),
        ),
      ),
    );
  }
}