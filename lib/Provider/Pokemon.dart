import 'dart:convert';

class Pokemon{
 final String name;
 Pokemon({required this.name});

//convertir de json a esta clase  Map<string> porque  siempre la primera clvae de un json es string y dynamic es como el optional en java
//porque el valor puede ser nulo o algun objeto o string . el return name: json['name'] es que esta obteniendo el valor en la clave name
 factory Pokemon.fromJson(Map<String,dynamic> json){
 return Pokemon(name: json['name']);
 }
}
