import 'package:flutter/material.dart';
import 'package:mycine_app/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        page = UserProfileScreen();
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
                    icon: Icon(Icons.person),
                    label: 'Perfil',
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
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
              TitleText(titleText: titleText, titulo:  'Categoria'),
              Container(
                padding: EdgeInsets.all(10),
                child: Categories(),
              ),
              TitleText(titleText: titleText, titulo: 'Recomendaciones'),
              Container(
                padding: EdgeInsets.all(10),
                height: 265,
                child: Recommend(),
              ),
            ],
          ),
        ));
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.titleText,
    required this.titulo,
  });

  final TextStyle titleText;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(titulo ,style: titleText ,),
    );
  }
} 


class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
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
    );
  }
}


class Recommend extends StatelessWidget {
  
  final CollectionReference moviesRef =
        FirebaseFirestore.instance.collection('movies');

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: moviesRef.snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final movies = snapshot.data?.docs ?? [];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: listaPeliculas(context, movie),
              );
            },
          );
        });
  }
  
  Widget listaPeliculas(BuildContext context, DocumentSnapshot document) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(document['posterUrl']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          document['titulo'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )),
      ],
    );
  }
}
