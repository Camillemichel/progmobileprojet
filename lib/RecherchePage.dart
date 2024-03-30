import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'RecherchePage_attente.dart';
import 'RecherchePage_Resultat.dart';
import 'main.dart';
import 'comics_page.dart';
import 'movie_page.dart';
import 'series_page.dart';

// Tableaux pour stocker les résultats
List<dynamic> moviesName = [];
List<dynamic> seriesName = [];
List<dynamic> issuesName = [];
List<dynamic> personnageName=[];

List<dynamic> moviesImage = [];
List<dynamic> seriesImage = [];
List<dynamic> issuesImage = [];
List<dynamic> personnageImage=[];

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

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TextField pour la saisie de texte
        Positioned(
          left: 29,
          top: 92,
          child: Container(
            width: 250, // Ajustez la largeur selon vos besoins
            height: 50,
            child: TextField(
              controller: _textEditingController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color.fromRGBO(21, 35, 46, 1),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ),
        // Icône SVG
        Positioned(
          left: 312.5,
          top: 107.5,
          child: GestureDetector(
            onTap: () {
              // Naviguer vers une nouvelle page avec les résultats de la recherche
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: RecherchePage_attente(query: _textEditingController.text),
                    );
                  },
                ),
              );
              Recherche(context,_textEditingController.text);
            },
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
        ),
      ],
    );
  }
}


class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(15, 30, 43, 1),
      // Couleur de fond de la barre de navigation
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // Distribuer les icônes uniformément
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AcceuilPage(title: "")), // Navigate vers RecherchePage
              );
            },
            child: NavigationIcon(
              iconPath: 'assets/navbar_home.svg',
              label: 'Accueil',
              showHighlight: false, // Seul l'élément "Accueil" aura le surlignage
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => comics_page()), // Navigate vers comics_page
              );
            },
            child: NavigationIcon(
              iconPath: 'assets/ic_books_bicolor.svg',
              label: 'Comics',
              showHighlight: false,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SeriesPage()), // Navigate vers SeriesPage
              );
            },
            child: NavigationIcon(
              iconPath: 'assets/ic_tv_bicolor.svg',
              label: 'Séries',
              showHighlight: false,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoviesPage()), // Navigate vers MoviesPage
              );
            },
            child: NavigationIcon(
              iconPath: 'assets/ic_movie_bicolor.svg',
              label: 'Films',
              showHighlight: false,
            ),
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

Future<void> Recherche(BuildContext context, String query) async {
  const apiKey = 'b912fd14613c0e92c4e7afe4733d855fb87679cc';
  const endpointMovies = 'movies';
  const endpointSeries = 'series_list';
  const endpointIssues = 'issues';
  const endpointPerso = 'characters';

  List<dynamic> movies = [];
  List<dynamic> series = [];
  List<dynamic> issues = [];
  List<dynamic> personnages = [];

  // Effectuer la recherche pour les films, séries et issues
  print("Recherche en cours dans l'API Comic Vine...");

  final apiUrlIssue =
      "https://comicvine.gamespot.com/api/${endpointIssues}?api_key=${apiKey}&format=json&limit=5&filter=name:${query}";
  final apiUrlSerie =
      "https://comicvine.gamespot.com/api/${endpointSeries}?api_key=${apiKey}&format=json&limit=5&filter=name:${query}";
  final apiUrlMovie =
      "https://comicvine.gamespot.com/api/${endpointMovies}?api_key=${apiKey}&format=json&limit=5&filter=name:${query}";
  final apiUrlPerso =
      "https://comicvine.gamespot.com/api/${endpointPerso}?api_key=${apiKey}&format=json&limit=5&filter=name:${query}";

  issues = await fetchData(apiUrlIssue);
  series = await fetchData(apiUrlSerie);
  movies = await fetchData(apiUrlMovie);
  personnages = await fetchData(apiUrlPerso);

  // Afficher les résultats dans la console
  print('Résultats de la recherche :');

  print('Films :');
  for (var movie in movies) {
    print('Titre: ${movie['name']}');
    print('Image: ${movie['image']['medium_url']}');
    print('---------------------');

    moviesName.add(movie['name']);
    moviesImage.add(movie['image']['medium_url']);
  }

  print('Séries :');
  for (var serie in series) {
    print('Titre: ${serie['name']}');
    print('Image: ${serie['image']['medium_url']}');
    print('---------------------');

    seriesName.add(serie['name']);
    seriesImage.add(serie['image']['medium_url']);
  }

  print('Issues :');
  for (var issue in issues) {
    print('Titre: ${issue['name']}');
    print('Image: ${issue['image']['medium_url']}');
    print('---------------------');

    issuesName.add(issue['name']);
    issuesImage.add(issue['image']['medium_url']);
  }

  print('Personnages :');
  for (var perso in personnages) {
    print('Titre: ${perso['name']}');
    print('Image: ${perso['image']['medium_url']}');
    print('---------------------');

    personnageName.add(perso['name']);
    personnageImage.add(perso['image']['medium_url']);
  }

  // Après avoir obtenu les résultats de la recherche, on les affiches sur la page de résultats
  navigateToResultPage(context, query);
}

Future<List<dynamic>> fetchData(String apiUrl) async {
  List<dynamic> list = [];

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    if (results.isNotEmpty) {
      list.addAll(results);
    }
  } else {
    print('Erreur de requête: ${response.statusCode}');
  }
  return list;
}

void navigateToResultPage(BuildContext context, String query) {
  Future.delayed(const Duration(milliseconds: 100), () {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: RecherchePage_Resultat(query: query,
              moviesName: moviesName, // Passer le tableau de films
              seriesName: seriesName, // Passer le tableau de séries
              issuesName: issuesName, // Passer le tableau d'issues
              personnageName: personnageName, // Passer le tableau de perso
              moviesImage: moviesImage, // Passer le tableau de films
              seriesImage: seriesImage, // Passer le tableau de séries
              issuesImage: issuesImage, // Passer le tableau d'issues
              personnageImage: personnageImage,// Passer le tableau de perso
            ),
          );
        },
      ),
    );
  });
}