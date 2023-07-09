import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn2/entities/pokemon.dart';

class PokemonDetailView extends StatefulWidget {
  @override
  _PokemonDetailViewState createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  int? pokemonId;
  Pokemon? pokemon;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final Map<String, dynamic>? arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      pokemonId = arguments?['id'];
      fetchData();
    });
  }

  Future<void> fetchData() async {
    if (pokemonId != null) {
      final response = await http
          .get(Uri.parse('http://192.168.1.27:8000/pokemon/$pokemonId'));
      if (response.statusCode == 200) {
        setState(() {
          final jsonData = json.decode(response.body);
          pokemon = Pokemon.fromJson(jsonData);
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Pokemón $pokemonId'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(child: Text('Hola pepis???')),
    );
  }
}
