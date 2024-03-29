import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn2/entities/pokemon.dart';
import 'package:url_launcher/url_launcher.dart';

class PokemonDetailView extends StatefulWidget {
  @override
  _PokemonDetailViewState createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  int? pokemonId;
  Pokemon? pokemon;
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _weightEditingController = TextEditingController();
  TextEditingController _heightEditingController = TextEditingController();
  TextEditingController _numberEditingController = TextEditingController();
  TextEditingController _imageUrlEditingController = TextEditingController();

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
          if (pokemon != null) {
            _nameEditingController.text = pokemon!.name;
            _weightEditingController.text = pokemon!.weight.toString();
            _heightEditingController.text = pokemon!.height.toString();
            _numberEditingController.text = pokemon!.number.toString();
            _imageUrlEditingController.text = pokemon!.imageUrl.toString();
          }
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    }
  }

  Future<void> sendData() async {
    pokemon!.name = _nameEditingController.text;
    pokemon!.height = double.parse(_heightEditingController.text);
    pokemon!.weight = double.parse(_weightEditingController.text);
    pokemon!.imageUrl = _imageUrlEditingController.text;
    pokemon!.number = int.parse(_numberEditingController.text);
    final response = await http
        .post(Uri.parse('http://192.168.1.27:8000/pokemon/save'), body: {
      'id': pokemon!.id.toString(),
      'name': pokemon!.name,
      'height': pokemon!.height.toString(),
      'weight': pokemon!.weight.toString(),
      'image_url': pokemon!.imageUrl,
      'number': pokemon!.number.toString(),
    });
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  void openFileManager() async {
    final url =
        'https://www.example.com'; // Replace with your desired URL or app scheme
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
        body: Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: 16.0), // Adjust the padding value as needed
                        child: pokemon != null
                            ? Center(
                                child: Image.network(
                                  pokemon!.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CircularProgressIndicator()), // Replace with your image path
                    Positioned(
                        bottom:
                            16.0, // Adjust the position of the icon as needed
                        right: 24.0,
                        child: GestureDetector(
                          onTap: () {
                            // Handle the click event
                            print('Positioned widget clicked!');
                            openFileManager();
                          },
                          child: Container(
                            width:
                                48.0, // Adjust the size of the container as needed
                            height: 48.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurple[
                                  300], // Adjust the color of the circle as needed
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.mode_edit_outline_outlined,
                                color: Colors
                                    .white, // Adjust the color of the icon as needed
                                size:
                                    26.0, // Adjust the size of the icon as needed
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
                TextField(
                  controller: _nameEditingController,
                  decoration: InputDecoration(
                      hintText: 'Ingrese un nombre', labelText: 'Nombre'),
                ),
                TextField(
                  controller: _weightEditingController,
                  decoration: InputDecoration(
                      hintText: 'Ingrese un peso en kg.', labelText: 'Peso'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _heightEditingController,
                  decoration: InputDecoration(
                      hintText: 'Ingrese una talla en m.',
                      labelText: 'Estatura'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _numberEditingController,
                  decoration: InputDecoration(
                      hintText: 'Ingrese un número de pokemon.',
                      labelText: 'Número'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _imageUrlEditingController,
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'No ingrese nada, se autogenera',
                      labelText: 'URL'),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            sendData();
                          },
                          child: Text('Guardar Cambios'),
                        ),
                      ),
                    ))
              ],
            )));
  }
}
