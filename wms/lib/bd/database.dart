import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:wms/bd/conexion_barra.dart';

class conexionHTTP extends StatefulWidget {
  String cod;
  conexionHTTP(this.cod, {Key? key}) : super(key: key);

  @override
  State<conexionHTTP> createState() => _conexionHTTPState();
}

class _conexionHTTPState extends State<conexionHTTP> {
  List<produc> data = <produc>[];
  Future<List<produc>> tomar_datos() async {
    var url =
        "https://dev.soferp.com/app/productos/barra?api_key=z0LxEbQGghVeX1dYNPlBqHHOaCrkuLSs&codigo_barra=${widget.cod}";

    var response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: 90));
    var datos = json.decode(response.body);
    print(datos);
    var registros = <produc>[];
    for (var item in datos) {
      print(item);
    }
    return registros;
  }

  @override
  void initState() {
    super.initState();
    tomar_datos().then((value) {
      setState(() {
        data.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 31, 31),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 2, 18, 53),
        elevation: 0,
        title: Text('Productos'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 280,
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 2),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              data[index].descripcion,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.cyan[800]),
                            )),
                        Text(
                          data[index].id,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan[800]),
                        ),
                        Text('Precio: ' + data[index].precio),
                        Text('Codigo de barras: ' + data[index].codigo_barras),
                        Text(data[index].error),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
