import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var textDescription = theme.textTheme.bodyMedium!.copyWith(
      color: Colors.white,
    );
    var bienvenida = 'Descubre las mejores películas y encuentra tu próxima obsesión.';


    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/img/Designer.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.5),
                Colors.black,
                Colors.black,
              ],
            )),
          ),
          Positioned(
            right: 40,
            left: 40,
            bottom: 100,
            child: Column(
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  width: 200,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 60,
                  child: Text(
                    bienvenida,
                    style: textDescription,
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,               
                    ),
                    child: Text('Ingresar'),                ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
