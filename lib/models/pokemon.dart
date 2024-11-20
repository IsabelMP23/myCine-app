class Pokemons {
  final String name;
  final String url;
  String? imageUrl;
  int? id;

   Pokemons({
    required this.name,
    required this.url,
    this.imageUrl,
    this.id,
  });

  factory Pokemons.fromJson(Map<String, dynamic> json){

    return Pokemons(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'url': url,
    };
  }
}

class PokemonListResponse {
  final List<Pokemons> results;

  PokemonListResponse({required this.results});

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Pokemons> resultsList = list.map((e) => Pokemons.fromJson(e)).toList();

    return PokemonListResponse(results: resultsList);
  }
}

