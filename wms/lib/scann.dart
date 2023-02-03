import 'package:flutter/material.dart';

class Scann extends StatefulWidget {
  @override
  _ScannState createState() => _ScannState();
}

class _ScannState extends State<Scann> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 213, 214, 215),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 72, 91, 133),
        elevation: 5,
        centerTitle: true,
        title: Text('Retrieve Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 320,
            width: 250,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    print("First text field: $text");
                  },
                ),
                TextField(
                  controller: myController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
