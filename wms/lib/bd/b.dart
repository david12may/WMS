import 'package:flutter/material.dart';

class ClassB extends StatelessWidget {
  final List<String> items;

  ClassB({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClassB'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
