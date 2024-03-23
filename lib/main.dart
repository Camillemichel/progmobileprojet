import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<dynamic> popularMoviesName = [];
List<dynamic> popularMoviesImage = [];
List<dynamic> popularSeriesName = [];
List<dynamic> popularSeriesImage = [];
List<dynamic> popularIssuesName = [];
List<dynamic> popularIssuesImage = [];

/** PAS LES BONNES POLICES ! A CHANGER PLUS TARD */

void main() async {

  const apiKey = 'b912fd14613c0e92c4e7afe4733d855fb87679cc';
  const endpointMovies = 'movies';
  const endpointSeries = 'series_list';
  const endpointIssues = 'issues';

  print('Recherche des films :');
  await searchMovies(apiKey, endpointMovies);

  print('\nRecherche des séries :');
  await searchSeries(apiKey, endpointSeries);

  final List<String> issuesToSearch = ['In the Hands of ... Mephisto!', 'Home', 'Batman in Bethlehem', '"The Black Issue"'];

  print('\nRecherche des issues :');
  await searchIssues(apiKey, endpointIssues, issuesToSearch);

  runApp(const MyApp());
}
Future<void> searchMovies(String apiKey, String endpoint) async {
  final apiUrl = "https://comicvine.gamespot.com/api/${endpoint}?api_key=${apiKey}&format=json&limit=4";
  final movies = await fetchData(apiUrl);
  for (final movie in movies) {
    print('Title: ${movie['name']}');
    print('image: ${movie['image']['icon_url']}');
    print('---------------------');
    popularMoviesName.add(movie['name']);
    popularMoviesImage.add(movie['image']['icon_url']);
  }
}

Future<void> searchSeries(String apiKey, String endpoint) async {
  final apiUrl = "https://comicvine.gamespot.com/api/${endpoint}?api_key=${apiKey}&format=json&limit=4";
  final series = await fetchData(apiUrl);
  for (final serie in series) {
    print('Title: ${serie['name']}');
    print('image: ${serie['image']['icon_url']}');
    print('---------------------');
    popularSeriesName.add(serie['name']);
    popularSeriesImage.add(serie['image']['icon_url']);
  }
}

Future<void> searchIssues(String apiKey, String endpoint, List<String> issuesToSearch) async {
  for (final issueName in issuesToSearch) {
    final apiUrlIssue = "https://comicvine.gamespot.com/api/${endpoint}?api_key=${apiKey}&format=json&limit=1&filter=name:${issueName}";

    final issues = await fetchData(apiUrlIssue);
    if (issues.isNotEmpty) {
      final issue = issues[0];
      if (issue['name'] != null) {
        print('Title: ${issue['name']}');
        print('image: ${issue['image']['icon_url']}');
        print('---------------------');
        popularIssuesName.add(issue['name']);
        popularIssuesImage.add(issue['image']['icon_url']);
      } else {
        print('Aucun titre disponible pour l\'issue: $issueName');
      }
    } else {
      print('Aucun issue trouvé pour: $issueName');
    }
  }
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
      home: MyHomePage(title:""),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required String title}) : super(key: key);

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
                      height: 1229,
                      color: Theme.of(context).colorScheme.background,
                      child: Stack(
                        children: [
                          /** BIENVENUE !*/
                          Positioned(
                            left: 32, // Position X du texte
                            top: 34, // Position Y du texte
                            child: Container(
                              width: 187, // Largeur du texte
                              height: 41, // Hauteur du texte
                              child: Center(
                                child: Text(
                                  "BIENVENUE !", // Texte
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
                          /** RECTANGLE SERIES POPULAIRES*/
                          PopularSeriesPart(),
                          /**SERIE POPULAIRE */
                          PopularSeriesSection(),
                          /** LOGO */
                          Positioned(
                            left: 244, // Position X de l'image
                            top: 16, // Position Y de l'image
                            child: SvgPicture.asset(
                              'assets/astronaut.svg', // Chemin vers l'image SVG
                              width: 121.85, // Largeur de l'image
                              height: 159.68, // Hauteur de l'image
                            ),
                          ),
                          /** Rectangle COMICS POPULAIRES */
                          PopularComicsPart(),
                          /** COMICS POPULAIRES */
                          PopularComicsSection(),
                          /** Rectangle FILMS POPULAIRES*/
                          PopularMoviesPart(),
                          /** FILMS POPULAIRES */
                          PopularMoviesSection(),
                        ],
                      ),
              ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
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
            showHighlight: true, // Seul l'élément "Accueil" aura le surlignage
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
            showHighlight: false,
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
            color: const Color.fromRGBO(55, 146, 255, 0.2), // Couleur de fond pour l'élément mis en évidence
            borderRadius: BorderRadius.circular(18), // Bordure arrondie
          ) : null,
          padding: showHighlight ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) : null,
          child: SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            color: showHighlight ? const Color.fromRGBO(55, 146, 255, 1) : const Color.fromRGBO(119, 139, 168, 1),
          ),
        ),
        const SizedBox(height: 8), // Espace constant entre l'icône et le texte
        Text(
          label,
          style: TextStyle(
            color: showHighlight ? const Color.fromRGBO(55, 146, 255, 1) : const Color.fromRGBO(119, 139, 168, 1),
            fontSize: 12,
            fontFamily: 'Nunito',
          ),
        ),
      ],
    );
  }
}class PopularSeriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < popularSeriesName.length; i++)
            Stack(
              children: [
                // Rectangle
                Container(
                  margin: EdgeInsets.only(left: i == 0 ? 26 : 10, top: 179), // Marge gauche
                  width: 180,
                  height: 242,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Coins arrondis
                    color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                  ),
                ),
                //Image
                Positioned(
                  left: i == 0 ? 26 : 10,
                  top: 179,
                  child: Container(
                    width: 180, // Largeur de l'image
                    height: 177, // Hauteur de l'image
                    child: Image.network(
                      popularSeriesImage[i], // URL de l'image
                    ),
                  ),
                ),
                // Texte
                Positioned(
                  left: i == 0 ? 34 : 10,
                  top: 368,
                  child: Container(
                    width: 156, // Largeur du texte
                    height: 44, // Hauteur du texte
                    child: Center(
                      child: Text(
                        popularSeriesName[i], // Texte
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

class PopularComicsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < popularMoviesName.length; i++)
            Stack(
              children: [
                // Rectangle
                Container(
                  margin: EdgeInsets.only(left: i == 0 ? 26 : 10, top: 524), // Marge gauche
                  width: 180,
                  height: 242,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Coins arrondis
                    color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                  ),
                ),
                //Image
                Positioned(
                  left: i == 0 ? 26 : 10,
                  top: 524,
                  child: Container(
                    width: 180, // Largeur de l'image
                    height: 177, // Hauteur de l'image
                    child: Image.network(
                      popularIssuesImage[i], // URL de l'image
                    ),
                  ),
                ),
                // Texte
                Positioned(
                  left: i == 0 ? 34 : 10,
                  top: 717,
                  child: Container(
                    width: 156, // Largeur du texte
                    height: 44, // Hauteur du texte
                    child: Center(
                      child: Text(
                        popularIssuesName[i], // Texte
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

class PopularMoviesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < popularMoviesName.length; i++)
            Stack(
              children: [
                // Rectangle
                Container(
                  margin: EdgeInsets.only(left: i == 0 ? 26 : 10, top: 877), // Marge gauche
                  width: 180,
                  height: 242,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Coins arrondis
                    color: const Color.fromRGBO(40, 76, 106, 1), // Couleur de fond
                  ),
                ),
                //Image
                Positioned(
                  left: i == 0 ? 26 : 10,
                  top: 877,
                  child: Container(
                    width: 180, // Largeur de l'image
                    height: 177, // Hauteur de l'image
                    child: Image.network(
                      popularMoviesImage[i], // URL de l'image
                    ),
                  ),
                ),
                // Texte
                Positioned(
                  left: i == 0 ? 34 : 10,
                  top: 1066,
                  child: Container(
                    width: 156, // Largeur du texte
                    height: 44, // Hauteur du texte
                    child: Center(
                      child: Text(
                        popularMoviesName[i], // Texte
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

class PopularSeriesPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 9, // Position X du rectangle
            top: 114, // Position Y du rectangle
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
            left: 272, // Position X du rectangle
            top: 140, // Position Y du rectangle
            child: Container(
              width: 92, // Largeur du rectangle
              height: 32, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                color: const Color.fromRGBO(0, 0, 0, 0.5), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 26, // Position X du rond
            top: 142, // Position Y du rond
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
            left: 26, // Position X du texte
            top: 133, // Position Y du texte
            child: Container(
              width: 205, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Séries populaires", // Texte
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
          Positioned(
            left: 295, // Position X du texte
            top: 145, // Position Y du texte
            child: Container(
              width: 57, // Largeur du texte
              height: 19, // Hauteur du texte
              child: Center(
                child: Text(
                  "Voir plus", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 14, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
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
class PopularComicsPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 9, // Position X du rectangle
            top: 460, // Position Y du rectangle
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
            left: 26, // Position X du rond
            top: 482, // Position Y du rond
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
            left: 30, // Position X du texte
            top: 472, // Position Y du texte
            child: Container(
              width: 205, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Comics populaires", // Texte
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
          Positioned(
            left: 274, // Position X du rectangle
            top: 474, // Position Y du rectangle
            child: Container(
              width: 92, // Largeur du rectangle
              height: 32, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                color: const Color.fromRGBO(0, 0, 0, 0.5), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 292, // Position X du texte
            top: 480, // Position Y du texte
            child: Container(
              width: 57, // Largeur du texte
              height: 19, // Hauteur du texte
              child: Center(
                child: Text(
                  "Voir plus", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 14, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
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

class PopularMoviesPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [

          Positioned(
            left: 9, // Position X du rectangle
            top: 809, // Position Y du rectangle
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
            left: 26, // Position X du rond
            top: 840, // Position Y du rond
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
            left: 45, // Position X du texte
            top: 831, // Position Y du texte
            child: Container(
              width: 175, // Largeur du texte
              height: 27, // Hauteur du texte
              child: Center(
                child: Text(
                  "Films populaires", // Texte
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
          Positioned(
            left: 274, // Position X du rectangle
            top: 831, // Position Y du rectangle
            child: Container(
              width: 92, // Largeur du rectangle
              height: 32, // Hauteur du rectangle
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Bordure arrondie
                color: const Color.fromRGBO(0, 0, 0, 0.5), // Couleur du fond
              ),
            ),
          ),
          Positioned(
            left: 292, // Position X du texte
            top: 837, // Position Y du texte
            child: Container(
              width: 57, // Largeur du texte
              height: 19, // Hauteur du texte
              child: Center(
                child: Text(
                  "Voir plus", // Texte
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1), // Couleur du texte
                    fontFamily: 'Nunito', // Police
                    fontSize: 14, // Taille du texte
                    fontWeight: FontWeight.normal, // Poids (Normal)
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