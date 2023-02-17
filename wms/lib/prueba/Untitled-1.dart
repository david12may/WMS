import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    if (DoneDataMap == null) {
      return Container(
          width: 300,
          height: 200,
          color: Colors.white,
          child: Center(
              child: Text(
            "El producto que ha ingresado, no existe",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          )));
    } else {
      return Container(
        width: 300,
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            Text(
              DoneDataMap!['descripcion'].toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Id producto: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DoneDataMap!['id'].toString(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Precio: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DoneDataMap!['precio'].toString(),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Cod. Barra: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DoneDataMap!['codigo_barras'].toString(),
                ),
              ],
            ),
            TextButton(onPressed: () {}, child: Text("Add Prod."))
          ],
        ),
      );
    }
  }
}
