import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wms/principal.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Inventario extends StatefulWidget {
  const Inventario({Key? key}) : super(key: key);

  @override
  State<Inventario> createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {
  String qrCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 213, 214, 215),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 72, 91, 133),
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
                                      child: Text(
                                        qrCode,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 30,
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 30,
                                        color: Color.fromARGB(255, 0, 200, 255),
                                        onPressed: () {},
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
                          width: 300,
                          child: ListView(
                            children: [
                              Row(
                                children: [
                                  Text("Coca Cola"),
                                  const Spacer(),
                                  Text("1")
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Agua"),
                                  const Spacer(),
                                  Text("1")
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Cajas de sabritas"),
                                  const Spacer(),
                                  Text("1")
                                ],
                              ),
                            ],
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
                      onPressed: () {
                        _Inicio(context);
                      },
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
        ));
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

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}

void _regresar(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Inventario()),
  );
}

void _Inicio(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Principal()),
  );
}
