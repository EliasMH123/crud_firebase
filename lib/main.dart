import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/agregar.dart';
import 'package:flutter_crud_firebase/vistaeditar.dart';

import 'package:flutter_crud_firebase/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database? bd;
  List docs = [];
  bool _isLoading = false;

  initdb() {
    bd = Database();
    bd!.init();
    bd!.read().then((value) => {
          setState(() {
            docs = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    _fetchEscuelas();
  }

  _fetchEscuelas() async {
    setState(() {
      _isLoading = true;
    });
    await initdb();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: const Text(
          "Escuelas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    margin: const EdgeInsets.all(30),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => vistaeditar(
                                      escuela: docs[index],
                                      bd: bd,
                                    ))).then((value) => {
                              if (value != null) {_fetchEscuelas()}
                            });
                      },
                      title: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(docs[index]['nombre'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(docs[index]['direccion'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Agregar(
                        bd: bd,
                      ))).then((value) => {
                if (value != null) {_fetchEscuelas()}
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[900],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
