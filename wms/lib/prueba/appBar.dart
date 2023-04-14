import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms/bd/post_conexion.dart';
import 'package:wms/inventario.dart';
import 'package:wms/prueba/noti.dart';

class custionario extends StatefulWidget {
  String as;
  custionario(this.as, {Key? key}) : super(key: key);

  @override
  State<custionario> createState() => _custionarioState();
}

class _custionarioState extends State<custionario> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  var empresaController = TextEditingController();
  var sucursalController = TextEditingController();
  var almacenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 1, 26, 82),
          elevation: 5,
          centerTitle: true,
          title: Text("Llena los Datos"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(255, 1, 26, 82),
                    Color.fromARGB(255, 0, 32, 65),
                  ])),
              child: CircleAvatar(
                child: Image.asset(
                  'assets/codigo.png',
                  scale: 3,
                  width: 300,
                ),
                radius: 100,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -40),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 260, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              controller: empresaController,
                              decoration:
                                  InputDecoration(labelText: "Numero Empresa:"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingrese el numero de Empresa';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _isButtonEnabled =
                                      _formKey.currentState!.validate();
                                });
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: sucursalController,
                              decoration: InputDecoration(
                                  labelText: "Numero de Sucursal"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingrese el numero de Sucursal';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _isButtonEnabled =
                                      _formKey.currentState!.validate();
                                });
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              controller: almacenController,
                              decoration: InputDecoration(
                                  labelText: "Numero del alamacen"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor ingrese el nuemro del almacen';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _isButtonEnabled =
                                      _formKey.currentState!.validate();
                                });
                              },
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            ButtonBar(children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 26, 62, 99),
                                  ),
                                ),
                                onPressed: () => _Cancelar(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Cancelar"),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 26, 62, 99),
                                  ),
                                ),
                                onPressed: _isButtonEnabled
                                    ? () => _login(context)
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Continuar"),
                                  ],
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _login(BuildContext context) async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String em = empresaController.text;
    String su = sucursalController.text;
    String al = almacenController.text;

    String O = formattedDate;
    String as = "${widget.as}";

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Enviar(
                as,
                O,
                su,
                em,
                al,
              )),
    );
  }

  Future<void> _Cancelar(BuildContext context) async {
    String a = "${widget.as}";

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Inventario(a)),
    );
  }
}
