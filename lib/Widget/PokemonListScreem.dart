import 'package:flutter/material.dart';
import 'package:pokemon/Provider/Pokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonListScreem extends StatefulWidget {
  const PokemonListScreem({super.key});

  @override
  State<PokemonListScreem> createState() => _PokemonListScreemState();
}

class _PokemonListScreemState extends State<PokemonListScreem> {
  //Crear una lista de pokemones
  late Future<List<Pokemon>> pokeList;

//Inicializar el widget con la peticion
  @override
  void initState() {
    super.initState();
    //Hacer la peticion
    pokeList = fetchPokemonList();
  }

//Funcion para hacer la peticion http
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      //recorrer cada item del diccionario(Map)
      List<Pokemon> pokeList =
          data.map((e) => Pokemon.fromJson(e as Map<String, dynamic>)).toList();
      return pokeList;
    } else {
      throw Exception("Error del servidor${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Lista de Pokemones"),
        backgroundColor: Colors.blue,
        
      ),
      drawer: Drawer(backgroundColor: Colors.black),
      //futureBilder
      body: FutureBuilder(
          future: pokeList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error ${{snapshot.hasError}}');
            } else {
              //Se convierte a tipo List<Pokemon>
              List<Pokemon> data = snapshot.data as List<Pokemon>;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(data[index].name));
                  });
            }
          }),
    ));
  }
}
