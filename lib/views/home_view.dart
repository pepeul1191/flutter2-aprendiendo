import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My first layoutR'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
          child: Text('Hola pepis???',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UbuntuFont',
                  letterSpacing: 2.0))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('++++++++++++++++++++++++++++');
        },
        tooltip: 'Agregar Registro',
        child: Icon(Icons.add), //,
        backgroundColor: Colors.deepPurple[300],
      ),
    );
  }
}
