import 'package:flutter/material.dart';
import 'package:mycine_app/models/pokemon.dart';
import 'package:mycine_app/services/api_service.dart';
import 'package:mycine_app/my_flutter_app_icons.dart';

class MyAppState extends ChangeNotifier {
  @override
  notifyListeners();
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = PokemonPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            body: mainArea,
            bottomNavigationBar: SafeArea(
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(MyFlutterApp.icons8_pokemon),
                    label: 'Pokemons',
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Inicio'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favoritos'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            ),
          );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titleText = Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: Colors.white,
        );
    var textDescription = Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Colors.white,
        );
    var description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque feugiat dui sit amet blandit imperdiet. Vestibulum pellentesque nibh et est egestas volutpat.";

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('MyCine', style: titleText),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
              color: Colors.white,
              iconSize: 30,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 3,
              child: Stack(children: [
                Container(
                  padding: EdgeInsets.all(50),
                  color: Theme.of(context).colorScheme.secondary,
                  height: 370,
                ),
                Positioned(
                    left: 30,
                    bottom: 70,
                    width: 320,
                    child: Text(description,
                        style: textDescription,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis)),
                Positioned(
                    left: 30,
                    bottom: 10,
                    child: ElevatedButton(
                        onPressed: () {}, child: Text('Ver más'))),
              ]),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Categories(),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Recommend(),
              ),
            ),
          ],
        ));
  }
}

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!.copyWith(
      color: Colors.white,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Categorías', style: style, semanticsLabel: 'Categorías'),
        SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Acción'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Drama'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Comedia'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Recommend extends StatelessWidget {
  const Recommend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.headlineSmall!.copyWith(
      color: Colors.white,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recomendaciones', style: style),
        SizedBox(height: 10),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigCard(),
              BigCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.bodySmall!.copyWith(
      color: Colors.white,
    );

    return Card(
      color: theme.colorScheme.secondary,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          width: 140,
          height: 200,
          child: Center(child: Text('Películas', style: style)),
        ),
      ),
    );
  }
}

class PokemonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Pokemons'),
        ),
        body: FutureBuilder<PokemonListResponse>(
          future: fetchPokemons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final pokemonsList = snapshot.data!.results;
              if (pokemonsList.isEmpty) {
                return Center(child: Text('Datos no disponibles.'));
              }

              return ListView.builder(
                itemCount: pokemonsList.length,
                itemBuilder: (context, index) {
                  var pokemon = pokemonsList[index];

                  return ListTile(
                    leading: pokemon.imageUrl != null
                        ? Image.network(pokemon.imageUrl!)
                        : Icon(Icons.error),
                    title: Text(pokemon.name, style: TextStyle(color: Colors.white),),
                    subtitle: Text('# ${pokemon.id}', style: TextStyle(color: Colors.white)),
                  );
                },
              );
            }
            return Center(child: Text('Sin datos'));
          },
        ));
  }
}
