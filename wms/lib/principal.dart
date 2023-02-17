import 'package:flutter/material.dart';
import 'package:wms/bd/prodcutos.dart';
import 'package:wms/prueba/Untitled-1.dart';
import 'package:wms/qr.dart';
import 'package:wms/scann.dart';
import 'inventario.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 213, 214, 215),
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: Colors.transparent,
        elevation: 20,
        flexibleSpace: ClipPath(
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 1, 26, 82),
                      Color.fromARGB(255, 0, 32, 65),
                    ])),
            child: Center(
              child: Text(
                'WMS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: 450,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              children: [
                Row(children: [
                  Container(
                    height: 150,
                    width: 120,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _inventario(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  'assets/codigo.png',
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 26, 62, 99),
                                    borderRadius: const BorderRadius.only(
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
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            text: "Inventario",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 150,
                    width: 120,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _qr(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.asset(
                                  'assets/codigo.png',
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 26, 62, 99),
                                    borderRadius: const BorderRadius.only(
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
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            text: "Funcion",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 120,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _Scann(context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    'assets/codigo.png',
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 26, 62, 99),
                                      borderRadius: const BorderRadius.only(
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
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              text: "Scann",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 150,
                      width: 120,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _bd(context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    'assets/codigo.png',
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 26, 62, 99),
                                      borderRadius: const BorderRadius.only(
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
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              text: "Database",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _inventario(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Inventario()),
    );
  }

  void _qr(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QR()),
    );
  }

  void _Scann(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scann()),
    );
  }

  void _bd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => bd()),
    );
  }
}
