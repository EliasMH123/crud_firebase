import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore? firestore;
  init() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore!.collection('escuelas').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map esc = {
            "id": doc.id,
            "nombre": doc['nombre'],
            "direccion": doc["direccion"],
          };
          docs.add(esc);
        }
        return docs;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return docs;
  }

  Future<void> update(String id, String nombre, String direccion) async {
    try {
      await firestore!
          .collection("escuelas")
          .doc(id)
          .update({'nombre': nombre, 'direccion': direccion});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> create(String nombre, String direccion) async {
    try {
      await firestore!
          .collection("escuelas")
          .add({'nombre': nombre, 'direccion': direccion});
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore!.collection("escuelas").doc(id).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
