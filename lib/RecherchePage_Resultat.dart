import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'RecherchePage.dart';
import 'DetailPersonnage_histoire.dart';
import 'DetailPersonnage_info.dart';
import 'main.dart';

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
      home: RecherchePage_Resultat(query:"",moviesName:[],seriesName:[],issuesName:[],personnageName: [],moviesImage:[],seriesImage:[],issuesImage:[],personnageImage: [],),
    );
  }
}

class RecherchePage_Resultat extends StatelessWidget {
  final String query;
  final List<dynamic> moviesName; // le tableau de noms de films
  final List<dynamic> seriesName; // Tableau de noms de séries
  final List<dynamic> issuesName; // Tableau de noms d'issues
  final List<dynamic>personnageName; // Tableau des noms des personnages
  final List<dynamic> moviesImage; // le tableau d'images de films
  final List<dynamic> seriesImage; // Tableau d'images de séries
  final List<dynamic> issuesImage; // Tableau d'images d'issues
  final List<dynamic> personnageImage; //Tableau d'images des personnages

  const RecherchePage_Resultat({
    Key? key,
    required this.query,
    required this.moviesName, // Assurez-vous de déclarer le paramètre movies ici
    required this.seriesName,
    required this.issuesName,
    required this.personnageName,
    required this.moviesImage, // Assurez-vous de déclarer le paramètre movies ici
    required this.seriesImage,
    required this.issuesImage,
    required this.personnageImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent, // Rendre la barre transparente
        elevation: 0, // Supprimer l'ombre de la barre
      ),
      body: SingleChildScrollView(
      child: Container(
        width: 375,
        height: 1720,
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
              SearchBar(query),

              /** Affichage des résultats de la recherche */
              /** Series */
              AffichageSeriesPart(),
              AffichageResultatSeries(),

              /** Comics */
              AffichageComicsPart(),
              AffichageResultatComics(),

              /** Films */
              AffichageMoviesPart(),
              AffichageResultatMovies(),

              /** Personnages */
              AffichagePersonnagePart(),
              AffichageResultatPersonnage(),

          ]),

      ),

      ),

      bottomNavigationBar: CustomBottomNavigationBar(),
      // Nettoyage des listes
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Clear lists here
          moviesName.clear();
          seriesName.clear();
          issuesName.clear();
          personnageName.clear();
          moviesImage.clear();
          seriesImage.clear();
          issuesImage.clear();
          personnageImage.clear();
        },
        child: Icon(Icons.clear),
      ),
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
               query,
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
        children:  [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AcceuilPage(title: "")
                ),
              );
            },
            child: NavigationIcon(
              iconPath: 'assets/navbar_home.svg',
              label: 'Accueil',
              showHighlight: false,
            ),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    RecherchePage(title: "")), // Navigate vers RecherchePage
              );
            },
            child: NavigationIcon(
              iconPath: 'assets/navbar_search.svg',
              label: 'Recherche',
              showHighlight: true, // Activez le surlignage pour l'icône de recherche
            ),
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
class AffichageResultatComics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (issuesName.isEmpty)
            Container(
              margin: EdgeInsets.only(left: 70, top: 696.5),
              width: 250, // Largeur du texte
              height: 44, // Hauteur du texte
              child: Center(
                child: Text(
                  "Aucun résultat trouvé",
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 22, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            )
          else
            for (int i = 0; i < issuesName.length; i++)
              Stack(
                children: [
                  // Rectangle
                  Container(
                    margin: EdgeInsets.only(left: i == 0 ? 31 : 10, top: 600), // Marge gauche
                    width: 180,
                    height: 242,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                      color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                    ),
                  ),
                  //Image
                  Positioned(
                    left: i == 0 ? 31 : 10,
                    top: 600,
                    child: Container(
                      width: 180, // Largeur de l'image
                      height: 177, // Hauteur de l'image
                      child: Image.network(
                        issuesImage[i], // URL de l'image
                      ),
                    ),
                  ),
                  // Texte
                  Positioned(
                    left: i == 0 ? 42 : 34,
                    top: 789,
                    child: Container(
                      width: 156, // Largeur du texte
                      height: 44, // Hauteur du texte
                      child: Center(
                        child: Text(
                          issuesName[i], // Texte
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                            fontFamily: 'Nunito', // Police
                            fontSize: 16, // Taille du texte
                            fontWeight: FontWeight.normal, // Poids (Normal)
                            fontStyle: FontStyle.normal, // Style de police
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}


class AffichageComicsPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 14, // Position X du rectangle
            top: 532, // Position Y du rectangle
            child: Container(
              width: 424, // Largeur du rectangle
              height: 329, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
              ),
            ),
          ),

          Positioned(
            left: 31, // Position X du rond
            top: 563, // Position Y du rond
            child: Container(
              width: 10, // Largeur du rond
              height: 10, // Hauteur du rond
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // Bordure arrondie pour faire un rond
                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 50, // Position X du texte
            top: 554, // Position Y du texte
            child: Container(
              width: 70, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Comics", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 20, // Taille du texte
                    fontWeight: FontWeight.bold, // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
}
class AffichageResultatSeries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (seriesName.isEmpty)
            Container(
              margin: EdgeInsets.only(left: 70, top: 347.5),
              width: 250, // Largeur du texte
              height: 44, // Hauteur du texte
              child: Center(
                child: Text(
                  "Aucun résultat trouvé",
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 22, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            )
          else
            for (int i = 0; i < seriesName.length; i++)
              Stack(
                children: [
                  // Rectangle
                  Container(
                    margin: EdgeInsets.only(left: i == 0 ? 31 : 10, top: 251), // Marge gauche
                    width: 180,
                    height: 242,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                      color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                    ),
                  ),
                  //Image
                  Positioned(
                    left: i == 0 ? 31 : 10,
                    top: 251,
                    child: Container(
                      width: 180, // Largeur de l'image
                      height: 177, // Hauteur de l'image
                      child: Image.network(
                        seriesImage[i], // URL de l'image
                      ),
                    ),
                  ),
                  // Texte
                  Positioned(
                    left: i == 0 ? 42 : 34,
                    top: 440,
                    child: Container(
                      width: 156, // Largeur du texte
                      height: 44, // Hauteur du texte
                      child: Center(
                        child: Text(
                          seriesName[i], // Texte
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                            fontFamily: 'Nunito', // Police
                            fontSize: 16, // Taille du texte
                            fontWeight: FontWeight.normal, // Poids (Normal)
                            fontStyle: FontStyle.normal, // Style de police
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class AffichageSeriesPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 14, // Position X du rectangle
            top: 183, // Position Y du rectangle
            child: Container(
              width: 424, // Largeur du rectangle
              height: 329, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
              ),
            ),
          ),

          Positioned(
            left: 31, // Position X du rond
            top: 214, // Position Y du rond
            child: Container(
              width: 10, // Largeur du rond
              height: 10, // Hauteur du rond
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), // Bordure arrondie pour faire un rond
                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 50, // Position X du texte
            top: 205, // Position Y du texte
            child: Container(
              width: 57, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Séries", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 20, // Taille du texte
                    fontWeight: FontWeight.bold, // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
}
class AffichageResultatMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (moviesName.isEmpty)
            Container(
              margin: EdgeInsets.only(left: 70, top: 1042.5),
              width: 250, // Largeur du texte
              height: 44, // Hauteur du texte
              child: Center(
                child: Text(
                  "Aucun résultat trouvé",
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 22, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            )
          else
            for (int i = 0; i < moviesName.length; i++)
              Stack(
                children: [
                  // Rectangle
                  Container(
                    margin: EdgeInsets.only(left: i == 0 ? 31 : 10, top: 946), // Marge gauche
                    width: 180,
                    height: 242,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                      color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                    ),
                  ),
                  //Image
                  Positioned(
                    left: i == 0 ? 31 : 10,
                    top: 946,
                    child: Container(
                      width: 180, // Largeur de l'image
                      height: 177, // Hauteur de l'image
                      child: Image.network(
                        moviesImage[i], // URL de l'image
                      ),
                    ),
                  ),
                  // Texte
                  Positioned(
                    left: i == 0 ? 42 : 34,
                    top: 1135,
                    child: Container(
                      width: 156, // Largeur du texte
                      height: 44, // Hauteur du texte
                      child: Center(
                        child: Text(
                          moviesName[i], // Texte
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                            fontFamily: 'Nunito', // Police
                            fontSize: 16, // Taille du texte
                            fontWeight: FontWeight.normal, // Poids (Normal)
                            fontStyle: FontStyle.normal, // Style de police
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}

class AffichageMoviesPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 14, // Position X du rectangle
            top: 878, // Position Y du rectangle
            child: Container(
              width: 424, // Largeur du rectangle
              height: 329, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
              ),
            ),
          ),

          Positioned(
            left: 31, // Position X du rond
            top: 909, // Position Y du rond
            child: Container(
              width: 10, // Largeur du rond
              height: 10, // Hauteur du rond
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // Bordure arrondie pour faire un rond
                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 50, // Position X du texte
            top: 900, // Position Y du texte
            child: Container(
              width: 57, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Films", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    // Couleur du texte
                    fontFamily: 'Nunito',
                    // Police
                    fontSize: 20,
                    // Taille du texte
                    fontWeight: FontWeight.bold,
                    // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
}
class AffichageResultatPersonnage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          if (moviesName.isEmpty)
            Container(
              margin: EdgeInsets.only(left: 70, top: 1391.5),
              width: 250, // Largeur du texte
              height: 44, // Hauteur du texte
              child: Center(
                child: Text(
                  "Aucun résultat trouvé",
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 22, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            )
          else
          for (int i = 0; i < personnageName.length; i++)
              Stack(
                children: [
                  // Rectangle
                  Container(
                    margin: EdgeInsets.only(left: i == 0 ? 31 : 10, top: 1295), // Marge gauche
                    width: 180,
                    height: 242,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                      color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                    ),
                  ),
                  //Image
                  Positioned(
                    left: i == 0 ? 31 : 10,
                    top: 1295,
                    child: Container(
                      width: 180, // Largeur de l'image
                      height: 177, // Hauteur de l'image
                      child: Image.network(
                        personnageImage[i], // URL de l'image
                      ),
                    ),
                  ),
                  // Texte
                  Positioned(
                    left: i == 0 ? 42 : 34,
                    top: 1484,
                    child: Container(
                      width: 156, // Largeur du texte
                      height: 44, // Hauteur du texte
                      child: Center(
                        child: Text(
                          personnageName[i], // Texte
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                            fontFamily: 'Nunito', // Police
                            fontSize: 16, // Taille du texte
                            fontWeight: FontWeight.normal, // Poids (Normal)
                            fontStyle: FontStyle.normal, // Style de police
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
            ),
        ],
      ),
    );
  }
}

class AffichagePersonnagePart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 14, // Position X du rectangle
            top: 1227, // Position Y du rectangle
            child: Container(
              width: 424, // Largeur du rectangle
              height: 329, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Bordure arrondie
                color: const Color.fromRGBO(30, 50, 67, 1), // Couleur du fond
              ),
            ),
          ),

          Positioned(
            left: 31, // Position X du rond
            top: 1258, // Position Y du rond
            child: Container(
              width: 10, // Largeur du rond
              height: 10, // Hauteur du rond
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // Bordure arrondie pour faire un rond
                color: const Color.fromRGBO(255, 129, 0, 1), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 50, // Position X du texte
            top: 1249, // Position Y du texte
            child: Container(
              width: 125, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Personnages", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    // Couleur du texte
                    fontFamily: 'Nunito',
                    // Police
                    fontSize: 20,
                    // Taille du texte
                    fontWeight: FontWeight.bold,
                    // Poids (Normal)
                    fontStyle: FontStyle.normal, // Style de police
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
}
