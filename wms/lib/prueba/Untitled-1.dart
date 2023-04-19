import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import 'package:wms/bd/conexion_barra.dart';
import 'package:wms/inventario.dart';
import 'package:wms/prueba/noti.dart';

class conexion extends StatefulWidget {
  String cod;
  String app;
  String aid;
  String empresa;
  String almacen;

  conexion(this.cod, this.app, this.aid, this.empresa, this.almacen, {Key? key})
      : super(key: key);

  @override
  State<conexion> createState() => _conexionState();
}

class _conexionState extends State<conexion> {
  List<String> _miLista = [];
  Map<String, int> _contador = {};

  List<String> items = [];
  Map<String, dynamic>? dataMap;
  Map<String, dynamic>? DoneDataMap;
  List<dynamic>? DoneListdata;

  Future hitAPI() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://dev.soferp.com/app/productos/barra?api_key=${widget.app}&codigo_barra=${widget.cod}"));

    List<produc> prod = [];
    List<Error> err = [];
    if (response.statusCode == 200) {
      setState(() {
        dataMap = jsonDecode(response.body);
        DoneDataMap = dataMap;
        print(DoneDataMap);
        _sabe();
      });
      String a = widget.app;
      String aid = widget.aid;
      String empresa = widget.empresa;
      String almacen = widget.almacen;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Inventario(a, aid, empresa, almacen)));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El producto se ha ingresado correctamente'),
          backgroundColor: Colors.greenAccent.shade700,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      FlutterRingtonePlayer.play(
        fromAsset: "assets/noti.wav",
        volume: 0.4,
      );
    } else {
      String a = widget.app;
      String aid = widget.aid;
      String empresa = widget.empresa;
      String almacen = widget.almacen;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Inventario(a, aid, empresa, almacen)));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('El producto que ha ingresado, no existe'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      FlutterRingtonePlayer.play(
        fromAsset: "assets/error.mp3",
        volume: 0.4,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    hitAPI();
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

  Future<void> agregarElemento() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'mi_lista';
    List<String> myList = prefs.getStringList(key) ?? [];
    myList.add('Nuevo elemento ${myList.length + 1}');
    prefs.setStringList(key, myList);
  }

  _saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedList = json.encode(items);
    await prefs.setString('myList', encodedList);
  }

  _addItem() {
    setState(() {
      items.add(
        DoneDataMap!['descripcion'].toString(),
      );
      _saveList();
      String a = widget.app;
      String aid = widget.aid;
      String empresa = widget.empresa;
      String almacen = widget.almacen;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Inventario(a, aid, empresa, almacen)),
      );
    });
  }

  _sabe() {
    setState(() {
      _miLista.add(DoneDataMap!['descripcion'].toString());
      _contador = _contarElementos(_miLista);
      _guardarListaEnSharedPrefs(_miLista);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (DoneDataMap == null) {
      return Container(
        color: Colors.white,
        child: CupertinoActivityIndicator(
          color: Colors.black,
          radius: 20,
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: CupertinoActivityIndicator(
          color: Colors.black,
          radius: 20,
        ),
      );
    }
  }
}
