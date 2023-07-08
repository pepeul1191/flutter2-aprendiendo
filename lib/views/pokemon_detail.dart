import 'package:flutter/material.dart';

class PokemonDetailView extends StatefulWidget {
  @override
  _PokemonDetailViewState createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de Pokemón'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(child: Text('Hola pepis???')),
    );
  }
}
