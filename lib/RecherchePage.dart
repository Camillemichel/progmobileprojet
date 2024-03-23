import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projet programmation mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: const Color(0xFF15232E), // Couleur de fond
        ),
        useMaterial3: true,
      ),
      home: RecherchePage(title:""),
    );
  }
}

class RecherchePage extends StatelessWidget {
  RecherchePage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: Colors.transparent, // Rendre la barre transparente
          elevation: 0, // Supprimer l'ombre de la barre
        ),
        body: Container(
          width: 375,
          height: 1229,
          color: Theme.of(context).colorScheme.background,
            child: Stack(
              children: [
              /** Rectangle */
              Container(
              width: 375,
              height: 163,
              child: Stack(
                children: [
                  Positioned(
                    left: -1,
                    top: 0,
                    child: Container(
                      width: 375,
                      height: 163,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        color: Color.fromRGBO(34, 49, 65, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /** RECHERCHE */
              Positioned(
              left: 32, // Position X du texte
              top: 34, // Position Y du texte
              child: Container(
                width: 290, // Largeur du texte
                height: 41, // Hauteur du texte
                child: Center(
                  child: Text(
                    "Recherche ", // Texte
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                      fontFamily: 'Nunito', // Police
                      fontSize: 30, // Taille du texte
                      fontWeight: FontWeight.bold, // Poids (Bold)
                      fontStyle: FontStyle.normal, // Style de police
                    ),
                  ),
                ),
              ),
            ),
            /** Barre de Recherche*/
              SearchBar(),
            /** Affichage du texte quand aucune recherche n'est encore effectuée */
              SearchRectangle(),
            /** LOGO */
            Positioned(
              left: 270.83, // Position X de l'image
              top: 327, // Position Y de l'image
              child: SvgPicture.asset(
                'assets/astronaut.svg', // Chemin vers l'image SVG
                width: 74.02, // Largeur de l'image
                height: 97, // Hauteur de l'image
              ),
            ),

        ]),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class SearchRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Positioned(
      left: 13,
      top: 354,
      child: Container(
        width: 348,
        height: 131,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(30,50,67, 1),
        ),
      ),
    ),
        Positioned(
          left: 36,
          top: 388,
          child: Container(
            width: 248,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saisissez une recherche pour trouver un ",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color.fromRGBO(31, 159, 255, 1),
                    height: 1.333,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "comics",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      ", ",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      "film",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      ", ",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      "série",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      " ou",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      " personnage",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                    Text(
                      ".",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(31, 159, 255, 1),
                        height: 1.333,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    ],
    );

  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 29,
          top: 92,
          child: Container(
            width: 321,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(21, 35, 46, 1),
            ),
          ),
        ),
        Positioned(
          left: 46,
          top: 105,
          child: Opacity(
            opacity: 0.5,
            child: Container(
              width: 200,
              height: 23,
              child: Text(
                "COMIC, FILM, SÉRIE…",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        ),
    // Icône SVG
      Positioned(
        left: 312.5,
        top: 107.5,
        child: Container(
        child: Center(
        child: SvgPicture.asset(
          'assets/navbar_search.svg',
          width: 15, // Taille de l'icône SVG
          height: 15, // Taille de l'icône SVG
          color: Color.fromRGBO(114, 140, 171, 1),
          ),
        ),
       ),
      ),
     ],
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(15, 30, 43, 1), // Couleur de fond de la barre de navigation
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribuer les icônes uniformément
        children: const [
          NavigationIcon(
            iconPath: 'assets/navbar_home.svg',
            label: 'Accueil',
            showHighlight: false, // Seul l'élément "Accueil" aura le surlignage
          ),
          NavigationIcon(
            iconPath: 'assets/ic_books_bicolor.svg',
            label: 'Comics',
            showHighlight: false,
          ),
          NavigationIcon(
            iconPath: 'assets/ic_tv_bicolor.svg',
            label: 'Séries',
            showHighlight: false,
          ),
          NavigationIcon(
            iconPath: 'assets/ic_movie_bicolor.svg',
            label: 'Films',
            showHighlight: false,
          ),
          NavigationIcon(
            iconPath: 'assets/navbar_search.svg',
            label: 'Recherche',
            showHighlight: true,
          ),
        ],
      ),
    );
  }
}

class NavigationIcon extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool showHighlight;

  const NavigationIcon({
    Key? key,
    required this.iconPath,
    required this.label,
    this.showHighlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: showHighlight ? BoxDecoration(
            color: const Color.fromRGBO(55, 146, 255, 0.2),
            // Couleur de fond pour l'élément mis en évidence
            borderRadius: BorderRadius.circular(18), // Bordure arrondie
          ) : null,
          padding: showHighlight ? const EdgeInsets.symmetric(
              horizontal: 12, vertical: 8) : null,
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: showHighlight
                ? const Color.fromRGBO(55, 146, 255, 1)
                : const Color.fromRGBO(119, 139, 168, 1),
          ),
        ),
        const SizedBox(height: 8), // Espace constant entre l'icône et le texte
        Text(
          label,
          style: TextStyle(
            color: showHighlight
                ? const Color.fromRGBO(55, 146, 255, 1)
                : const Color.fromRGBO(119, 139, 168, 1),
            fontSize: 12,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}