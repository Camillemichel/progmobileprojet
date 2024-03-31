import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../api.dart';
import 'dart:ui';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class SerieDetailsPage extends StatefulWidget {
  final dynamic comic;

  const SerieDetailsPage({Key? key, required this.comic}) : super(key: key);

  @override
  _SerieDetailsPageState createState() => _SerieDetailsPageState();
}

class _SerieDetailsPageState extends State<SerieDetailsPage> {
  String selectedMenuItem = 'Histoire';
  Map<String, dynamic> _serieData = {};
  Map<String, dynamic> _episodeData = {};

  @override
  void initState() {
    super.initState();
    _fetchSerieData();
  }

  Future<void> _fetchSerieData() async {
    try {
      final api = ComicVineApi();
      final data = await api.searchSerieByName(widget.comic['id']);
      //print('API Response: $data');
      setState(() {
        _serieData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchEpisodeData(int id) async {
    try {
      final api = ComicVineApi();
      final data = await api.searchEpisodeByName(id);
      //print('API Response: $data');
      print("offefefezefefefeffefefekd");
      setState(() {
        _episodeData[id.toString()] = data; // Stock
        print("TESTTT" + ":" + _episodeData['version']);
      });
    } catch (e) {
      print(e);
    }

    // print(_episodeData[id.toString()]?['image']);
  }

  @override
  Widget build(BuildContext context) {
    final comic = widget.comic;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          comic['name'],
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with blur effect
          Image.network(
            comic['image']['small_url'],
            fit: BoxFit.cover,
          ),
          // Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              comic['image']['small_url'],
                              width: 94,
                              height: 127,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " ${comic['count_of_episodes']} episodes",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${comic['start_year']?.substring(0, 4) ?? 'N/A'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMenuItem = 'Histoire';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Histoire'
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Histoire',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Histoire'
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMenuItem = 'Personnages';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Personnages'
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Personnages',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Personnages'
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMenuItem = 'Episodes';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Episodes'
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Episodes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Episodes'
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Rectangle behind description
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.7, // ou toute autre hauteur souhaitée
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3243),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 27.0, bottom: 8.0, right: 27.0),
                    child: selectedMenuItem == 'Histoire'
                        ? HtmlWidget(
                      comic['description'] ?? 'N/A',
                    )
                        : selectedMenuItem == 'Personnages'
                        ? (_serieData['characters'] != null &&
                        _serieData['characters'].length > 0)
                        ? ListView.builder(
                      itemCount: _serieData['characters'].length,
                      itemBuilder: (context, index) {
                        final character =
                        _serieData['characters'][index];
                        return Text(
                            character['name'] ?? 'N/A',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 17));
                      },
                    )
                        : const Text('Aucun personnage trouvé')
                        : selectedMenuItem == 'Episodes'
                        ? (_serieData['episodes'] != null && _serieData['episodes'].length > 0)
                        ? Expanded( // Ajouter un widget Expanded ici
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _serieData['episodes'].length,
                        itemBuilder: (context, index) {
                          final episode = _serieData['episodes'][index];
                          _fetchEpisodeData(episode['id']); // Appel de _fetchEpisodeData avec l'ID de l'épisode
                          final episodeImageUrl = _episodeData[episode['id'].toString()]?['image']['small_url'] ?? "";
                          return ListTile(
                            leading: episodeImageUrl.isNotEmpty // Vérifier si l'URL de l'image n'est pas vide
                                ? Image.network( // Afficher l'image de l'épisode
                              episodeImageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                                : null, // Sinon, ne rien afficher
                            title: Text(
                              'Episode ${index+1}', // Utiliser l'ID de l'épisode pour récupérer le nom
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              episode['name'] ?? 'N/A',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    )
                        : const Text('Aucun épisode trouvé')
                        : const Text('Episodes',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
