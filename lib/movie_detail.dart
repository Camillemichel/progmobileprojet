import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'api.dart';
import 'dart:ui';
class MovieDetailsPage extends StatefulWidget {
  final dynamic comic;
  const MovieDetailsPage({Key? key, required this.comic}) : super(key: key);
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}
class _MovieDetailsPageState extends State<MovieDetailsPage> {
  String selectedMenuItem = 'Synopsis';
  Map<String, dynamic> _movieData = {};
  @override
  void initState() {
    super.initState();
    _fetchMovieData();
  }
  Widget _buildInfoRow(String label, dynamic value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
          if (value is List)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: value.map<Widget>((item) => Text(item, style: TextStyle(color: Colors.white))).toList(),
            )
          else
            Text(value, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  List<String> _getWritersNames() {
    List<String> writers = [];
    for (var writer in _movieData['writers']) {
      writers.add(writer['name']);
    }
    return writers;
  }
  List<String> _getStudioNames() {
    List<String> studios = [];
    for (var studio in _movieData['studios']) {
      studios.add(studio['name']);
    }
    return studios;
  }
  List<String> _getProducerNames() {
    List<String> producers = [];
    for (var producer in _movieData['producers']) {
      producers.add(producer['name']);
    }
    return producers;
  }
  Future<void> _fetchMovieData() async {
    try {
      final api = ComicVineApi();
      final data = await api.searchMovieByName(widget.comic['id']);
      print('API Response: $data');
      setState(() {
        _movieData = data;
      });
    } catch (e) {
      print(e);
    }
  }
  String shortenPrice(dynamic price) {
    if (price == null) {
      return 'N/A';
    }
    double priceDouble = double.tryParse(price.toString()) ?? 0;
    if (priceDouble < 1000000) {
      return '${price} \$';
    } else {
      double priceMillions = priceDouble / 1000000;
      return '${priceMillions.toStringAsFixed(0)} millions \$';
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
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Synopsis'
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Synopsis',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Synopsis'
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
                          selectedMenuItem = 'Infos';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0, right: 16.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: selectedMenuItem == 'Infos'
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 4,
                            ),
                          ),
                        ),
                        child: Text(
                          'Infos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedMenuItem == 'Infos'
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
                    child: selectedMenuItem == 'Synopsis'
                        ? Text(
                      comic['description'] ?? 'N/A',
                      style: TextStyle(color: Colors.white),
                    )
                        : selectedMenuItem == 'Personnages'
                        ? (_movieData['characters'] != null &&
                        _movieData['characters'].length > 0)
                        ? ListView.builder(
                      itemCount: _movieData['characters'].length,
                      itemBuilder: (context, index) {
                        final character =
                        _movieData['characters'][index];
                        return Text(character['name'] ?? 'N/A',
                            style:
                            const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 17
                            ));
                      },
                    )
                        : const Text('Aucun personnage trouvé')
                        : selectedMenuItem == 'Infos'
                        ? ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _buildInfoRow('Classification', _movieData['rating'] ?? 'N/A'),
                        _buildInfoRow('Scénaristes', _getWritersNames()),
                        _buildInfoRow('Producteurs', _getProducerNames()),
                        _buildInfoRow('Studios', _getStudioNames()),
                        _buildInfoRow('Budget', shortenPrice(_movieData['budget'])),
                        _buildInfoRow('Recettes au box-office', shortenPrice(_movieData['box_office_revenue'])),
                        _buildInfoRow('Recettes brutes totales', shortenPrice(_movieData['total_revenue'])),
                      ],
                    )
                        : const Text('Infos', style: TextStyle(color: Colors.white)),
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
