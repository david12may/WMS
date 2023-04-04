import 'package:flutter/material.dart';

class MiObjeto {
  final String titulo;
  final String descripcion;

  MiObjeto({required this.titulo, required this.descripcion});
}

class Scann extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejemplo setState',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MiWidget(),
    );
  }
}

class MiWidget extends StatefulWidget {
  @override
  _MiWidgetState createState() => _MiWidgetState();
}

class _MiWidgetState extends State<MiWidget> {
  List<MiObjeto> _miLista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejemplo setState'),
      ),
      body: ListView.builder(
        itemCount: _miLista.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_miLista[index].titulo),
            subtitle: Text(_miLista[index].descripcion),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VistaParaAgregarObjeto(agregarObjeto: agregarObjeto),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void agregarObjeto(MiObjeto objeto) {
    setState(() {
      _miLista.add(objeto);
    });
  }
}

class VistaParaAgregarObjeto extends StatefulWidget {
  final Function agregarObjeto;

  VistaParaAgregarObjeto({required this.agregarObjeto});

  @override
  _VistaParaAgregarObjetoState createState() => _VistaParaAgregarObjetoState();
}

class _VistaParaAgregarObjetoState extends State<VistaParaAgregarObjeto> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar objeto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El título es requerido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La descripción es requerida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final objeto = MiObjeto(
                      titulo: _tituloController.text,
                      descripcion: _descripcionController.text,
                    );
                    widget.agregarObjeto(objeto);
                    Navigator.pop(context);
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
