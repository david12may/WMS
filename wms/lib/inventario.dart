import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms/bd/post_conexion.dart';
import 'package:wms/bd/prodcutos.dart';
import 'package:wms/principal.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:wms/prueba/Untitled-1.dart';
import 'package:wms/prueba/appBar.dart';

import 'bd/lista_cache.dart';

class Inventario extends StatefulWidget {
  String a;
  Inventario(this.a, {Key? key}) : super(key: key);

  @override
  State<Inventario> createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {
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

  _borrar() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String as = widget.a;
    String O = formattedDate;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => custionario(as)));
  }

  Map<String, int> _contarElementos(List<String> lista) {
    Map<String, int> contador = {};
    lista.forEach((elemento) {
      contador[elemento] = (contador[elemento] ?? 0) + 1;
    });
    return contador;
  }

  String qrCode = '';

  TextEditingController codigo_barra = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    TextEditingController codigo_barra = TextEditingController(text: "");
    return Container(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 213, 214, 215),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 1, 26, 82),
            elevation: 5,
            centerTitle: true,
            title: Text("Inventario"),
          ),
          body: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 40.0),
                      child: Container(
                        height: 50,
                        width: 300,
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 150,
                                      child: Center(
                                        child: TextField(
                                          controller: codigo_barra,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 30,
                                      child: Center(
                                        child: IconButton(
                                          iconSize: 30,
                                          color:
                                              Color.fromARGB(255, 0, 200, 255),
                                          onPressed: () {
                                            String cod = codigo_barra.text;
                                            String app = widget.a;
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        conexion(cod, app)));
                                          },
                                          icon: Icon(Icons.add_circle),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 26, 62, 99),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  scanQRCode();
                                },
                                icon: Icon(Icons.camera),
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        "Prodcutos almacenados",
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 450,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: Column(children: [
                          Container(
                            child: Row(
                              children: [
                                Text(qrCode),
                                Text(
                                  "PRODUCTOS",
                                  style: TextStyle(fontSize: 17),
                                ),
                                const Spacer(),
                                Text(
                                  "PIEZAS/U",
                                  style: TextStyle(fontSize: 17),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 370,
                            width: 330,
                            child: ListView.builder(
                              itemCount: _contador.length,
                              itemBuilder: (BuildContext context, int index) {
                                String elementoActual =
                                    _contador.keys.elementAt(index);
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
                            ),
                          ),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 26, 62, 99),
                      ),
                      child: TextButton(
                        onPressed: _borrar,
                        child: Text(
                          "Finalizar Tarea",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      String cod = qrCode;
      String app = widget.a;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => conexion(
                    cod,
                    app,
                  )));
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
