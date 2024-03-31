import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/series_detail.dart';
import '../api.dart';
import 'main.dart';
import 'RecherchePage.dart';
import 'movie_page.dart';
import 'series_page.dart';
import 'comics_page.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({Key? key}) : super(key: key);
  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  List<dynamic> _series = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final api = ComicVineApi();
    final data = await api.getData('series_list');
    setState(() {
      _series = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width; // Largeur totale de l'écran

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Stack(
          children: [
            const Positioned(
              left: 32,
              top: 34,
              child: SizedBox(
                width: 290,
                height: 82,
                child: Center(
                  child: Text(
                    "Series les plus populaires",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Nunito',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 137,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: _series.isEmpty
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: _series.length,
                        itemBuilder: (BuildContext context, int index) {
                          final comic = _series[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SerieDetailsPage(comic: comic)),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  padding: const EdgeInsets.only(
                                      top: 21.0,
                                      bottom: 12.0,
                                      left: 14.0,
                                      right: 14.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E3243),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          width: 128.86,
                                          height: 132.62,
                                          child: Image.network(
                                            comic['image']['medium_url'],
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${comic['name']} ${index + 1}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              '${comic['count_of_episodes	']} episodes' ??
                                                  'N/A',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Text(
                                              comic['start_year	'] ?? 'N/A',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  left: 23,
                                  child: Container(
                                    width: 59.36,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '#${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
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
              showHighlight: true,
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
              showHighlight: false, // Activez le surlignage pour l'icône de recherche
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