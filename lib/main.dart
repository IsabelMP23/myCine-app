import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'myCine',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
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
        page = FavoritesPage();
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
                    icon: Icon(Icons.favorite),
                    label: 'Favoritos',
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
    var description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque feugiat dui sit amet blandit imperdiet. Vestibulum pellentesque nibh et est egestas volutpat."; 


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
                    child:
                        Text(description, style: textDescription, maxLines: 3, softWrap: true, overflow: TextOverflow.ellipsis)),
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
      color: Colors.black,
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
      color: Colors.black,
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

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text('Tienes 0 favoritos:'),
          ),
        ),
      ],
    );
  }
}
