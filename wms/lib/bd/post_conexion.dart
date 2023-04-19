import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms/inventario.dart';

class Enviar extends StatefulWidget {
  String as;

  String sucursal;
  String empresa;
  String almacen;

  Enviar(this.as, this.sucursal, this.empresa, this.almacen, {Key? key})
      : super(key: key);

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

    List<String> myItems =
        List<String>.from(prefs.getStringList('miLista') ?? []);
    Map<String, dynamic> jsonMap = {
      'count': myItems.length,
      'items': myItems,
    };
    String jsonString = json.encode(jsonMap);

    Map<String, dynamic> mapa = {'concepto': listaGuardada};

    final dartList = List<String>.from(myList!);
    final mappedList = dartList
        .map((item) => {
              "concepto": item,
              "producto_id": 31,
              "unidad_id": 1,
              "cantidad": 10,
              "costo": 1,
              "total": 2,
              "importe": 1
            })
        .toList();

    for (final item in mappedList) {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String hora = formatter.format(now);

      final json = jsonEncode(item);
      if (listaGuardada != null) {
        String listaJSON = jsonEncode(listaGuardada);

        final url = Uri.parse(
            'https://dev.soferp.com/app/inventarios_fisicos?api_key=${widget.as}');
        final headers = {'Content-Type': 'application/json'};
        final data = {
          "empresa_id": "${widget.empresa}",
          "sucursal_id": "${widget.sucursal}",
          "almacen_id": "${widget.almacen}",
          "fecha": hora,
          "tipo_aplicacion": 1,
          "detalles": mappedList,
        };

        final body = jsonEncode(data);

        final response = await http.post(url, headers: headers, body: body);

        if (response.statusCode == 200) {
          String a = widget.as;
          String aid = widget.sucursal;
          String empresa = widget.empresa;
          String almacen = widget.almacen;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Inventario(a, aid, empresa, almacen)));
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
          print(data);

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
          String a = widget.as;
          String aid = widget.sucursal;
          String empresa = widget.empresa;
          String almacen = widget.almacen;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Inventario(a, aid, empresa, almacen)));
          print('Error al enviar datos: ${response.statusCode}');
          print(data);
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
