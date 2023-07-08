import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String responseData = '';

  void fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.27:8000/pokemon/list'));
    print('2 ++++++++++++++++++++++++++++');
    if (response.statusCode == 200) {
      setState(() {
        responseData = response.body;
        print(responseData);
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
          child: Text('Hola pepis???',
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
