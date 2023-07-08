import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn2/entities/pokemon.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String responseData = 'Hola pepis???';
  List<Pokemon> pokemons = [];

  void fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.27:8000/pokemon/list'));
    if (response.statusCode == 200) {
      setState(() {
        final jsonData = json.decode(response.body);
        pokemons = (jsonData as List)
            .map((pokemonJson) => Pokemon.fromJson(pokemonJson))
            .toList();
        print(pokemons[0].name);
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    print('1 ++++++++++++++++++++++++++++');
    fetchData();
    print('3 ++++++++++++++++++++++++++++');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My first layoutR'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
          child: Text(responseData,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UbuntuFont',
                  letterSpacing: 2.0))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('++++++++++++++++++++++++++++');
          Navigator.pushNamed(context, '/pokemon/detail');
        },
        tooltip: 'Agregar Registro',
        child: Icon(Icons.add), //,
        backgroundColor: Colors.deepPurple[300],
      ),
    );
  }
}
