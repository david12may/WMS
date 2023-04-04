import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Hora extends StatelessWidget {
  const Hora({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fecha actual'),
        ),
        body: Center(
          child: Text('La fecha actual es: $formattedDate'),
        ),
      ),
    );
  }
}
