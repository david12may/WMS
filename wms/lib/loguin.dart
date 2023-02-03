import 'package:flutter/material.dart';
import 'package:wms/principal.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 234),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Container(
                  child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/codigo.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Color.fromARGB(174, 255, 255, 255)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Container(
                              child: Text("Usuario"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              height: 50,
                              width: 250,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(),
                              )),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              child: Text("Contraseña"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white,
                              ),
                              height: 50,
                              width: 250,
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                          _principal(context);
                        },
                        child: Text(
                          "Loguin",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

void _principal(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Principal()),
  );
}
