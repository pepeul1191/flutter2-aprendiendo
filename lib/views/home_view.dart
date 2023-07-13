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
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My first layout'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: /*Center(
          child: Text(responseData,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UbuntuFont',
                  letterSpacing: 2.0)))*/
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                mainAxisSpacing: 8.0, // Spacing between rows
                crossAxisSpacing: 8.0, // Spacing between columns
              ),
              itemCount: pokemons.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      // Handle the tap event.
                      print('Grid tile ${pokemons[index].id} tapped');
                      Navigator.pushNamed(context, '/pokemon/detail',
                          arguments: {'id': pokemons[index].id});
                    },
                    child: GridTile(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Image.network(
                            pokemons[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ));
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/pokemon/detail');
        },
        tooltip: 'Agregar Registro',
        child: Icon(Icons.add), //,
        backgroundColor: Colors.deepPurple[300],
      ),
    );
  }
}
