import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database.dart';

class vistaeditar extends StatefulWidget {
  vistaeditar({Key? key, this.escuela, this.bd}) : super(key: key);
  Map? escuela;
  Database? bd;
  @override
  _vistaeditarState createState() => _vistaeditarState();
}

class _vistaeditarState extends State<vistaeditar> {
  TextEditingController nombreController = new TextEditingController();
  TextEditingController direccionController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print(widget.escuela);
    nombreController.text = widget.escuela!['nombre'];
    direccionController.text = widget.escuela!['direccion'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Editar Escuela"),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.bd!.delete(widget.escuela!["id"]);
                Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Nombre"),
                controller: nombreController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Direccion"),
                controller: direccionController,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          // ignore: deprecated_member_use
          child: RaisedButton(
              color: Colors.white,
              onPressed: () {
                widget.bd!.update(widget.escuela!['id'], nombreController.text,
                    direccionController.text);
                Navigator.pop(context, true);
              },
              child: const Text(
                "Guardar",
                style: TextStyle(color: Colors.black),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}
