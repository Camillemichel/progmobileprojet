import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../api.dart';
import 'dart:ui';
import 'DetailPersonnage_histoire.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MovieDetailsPage extends StatefulWidget {
  final dynamic comic;

  const MovieDetailsPage({Key? key, required this.comic}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  String selectedMenuItem = 'Synopsis'; // Initial selection
  Map<String, dynamic> _movieData = {}; // Initialize _movieData to an empty map

  @override
  void initState() {
    super.initState();
    _fetchMovieData();
  }

  Future<void> _fetchMovieData() async {
    try {
      final api = ComicVineApi();
      final data = await api.searchMovieByName(widget.comic['name']);
      print('API Response: $data'); // Ajouter cet appel print()
      setState(() {
        _movieData = data;
      });
    } catch (e) {
      print(e);
    }
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
                                  " ${comic['runtime']} minutes",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${comic['release_date']?.substring(0, 4) ?? 'N/A'}',
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
                          selectedMenuItem = 'Synopsis';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Synopsis' ? Colors.orange : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Synopsis',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Synopsis' ? Colors.white : Colors.white.withOpacity(0.6),
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
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Personnages' ? Colors.orange : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Personnages',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Personnages' ? Colors.white : Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMenuItem = 'Infos';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Infos' ? Colors.orange : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Infos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Infos' ? Colors.white : Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Rectangle behind description
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // ou toute autre hauteur souhaitée
                  width : MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3243),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 25.0, left: 27.0, bottom: 8.0, right: 27.0),
                    child: selectedMenuItem == 'Synopsis'
                        ? HtmlWidget(comic['description'] ?? 'N/A'
                    )
                        : selectedMenuItem == 'Personnages'
                        ? (_movieData.isNotEmpty)
                        ? ListView.builder(
                      itemCount: _movieData['results'].length,
                      itemBuilder: (context, index) {
                        final character = _movieData['results'];
                        return Text(
                            character ?? 'N/A',
                          style: TextStyle(color: Colors.white),
                        );
                      },
                    )
                        : CircularProgressIndicator()
                        : Text('Infos'), // Show description or character list based on selection
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
