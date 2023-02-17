import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:wms/bd/conexion_barra.dart';

class conexion extends StatefulWidget {
  String cod;
  conexion(this.cod, {Key? key}) : super(key: key);

  @override
  State<conexion> createState() => _conexionState();
}

class _conexionState extends State<conexion> {
  Map<String, dynamic>? dataMap;
  Map<String, dynamic>? DoneDataMap;
  List<dynamic>? DoneListdata;

  Future hitAPI() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://dev.soferp.com/app/productos/barra?api_key=z0LxEbQGghVeX1dYNPlBqHHOaCrkuLSs&codigo_barra=${widget.cod}"));

    List<produc> prod = [];
    if (response.statusCode == 200) {
      setState(() {
        dataMap = jsonDecode(response.body);
        DoneDataMap = dataMap;
        print(DoneDataMap);
      });
      //String body = utf8.decode(response.bodyBytes);
      //final jsonData = jsonDecode(body);

      //return jsonData;
    } else {
      print("No se encontro ningunproducto");
    }
  }

  @override
  void initState() {
    super.initState();
    hitAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoneDataMap == null
          ? CupertinoActivityIndicator()
          : AlertDialog(
              title: Text(
                DoneDataMap!['descripcion'].toString(),
              ),
              content: Column(
                children: [
                  Text(
                    DoneDataMap!['id'].toString(),
                  ),
                  Text(
                    DoneDataMap!['precio'].toString(),
                  ),
                  Text(
                    DoneDataMap!['codigo_barras'].toString(),
                  ),
                ],
              ),
            ),
    );
  }
}
