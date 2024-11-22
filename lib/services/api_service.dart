import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycine_app/models/pokemon.dart';

Future<PokemonListResponse> fetchPokemons() async {
  final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=15&offset=0');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    var pokemonList = PokemonListResponse.fromJson(json);

    for (var pokemon in pokemonList.results) {
      final details = await http.get(Uri.parse(pokemon.url));
      if (details.statusCode == 200) {
        final json = jsonDecode(details.body);
        pokemon.imageUrl = json['sprites']['front_default'];
        pokemon.id = json['id'] ;
      } else {
        throw Exception('Error al cargar imagen de pokemon');
      }
    }

    return pokemonList;
  } else {
    throw Exception('Error al cargar lista de pokemons');
  }
}
