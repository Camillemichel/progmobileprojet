import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      home: RecherchePage_attente(query:""),
    );
  }
}
class RecherchePage_attente extends StatelessWidget {

  final String query;
  const RecherchePage_attente({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent, // Rendre la barre transparente
        elevation: 0, // Supprimer l'ombre de la barre
      ),
      //body: SingleChildScrollView(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              left: 32,
              top: 34,
              child: Container(
                width: 290,
                height: 41,
                child: Center(
                  child: Text(
                    "Recherche ",
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Nunito',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            /** Barre de Recherche*/
            SearchBar(query),
            /** Affichage du texte quand aucune recherche n'est encore effectuée */
            SearchRectangle(),
            /** LOGO */
            Positioned(
              left: 105.83, // Position X de l'image
              top: 283, // Position Y de l'image
              child: SvgPicture.asset(
                'assets/astronaut.svg', // Chemin vers l'image SVG
                width: 157.95, // Largeur de l'image
                height: 207, // Hauteur de l'image
              ),
            ),
          ],
        ),
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
          top: 440,
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
          left: 117,
          top: 505,
            child: Container(
              width: 134,
              height: 40,
              child: Text(
                "Recherche en cours Merci de patienter",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color.fromRGBO(31, 159, 255, 1),
                ),
              ),
            ),
          ),
       ],
    );
  }
}
class SearchBar extends StatelessWidget {
  final String query;

  const SearchBar(this.query);

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
                query, // Afficher le texte saisi dans la barre de recherche
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
        Positioned(
          left: 312.5,
          top: 107.5,
          child: Container(
            child: Center(
              child: SvgPicture.asset(
                'assets/navbar_search.svg',
                width: 15,
                height: 15,
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
