import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:learn2/views/home_view.dart';
import 'package:learn2/views/pokemon_detail.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/pokemon/detail': (context) => PokemonDetailView(),
      },
    ));
