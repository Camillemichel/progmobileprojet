import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../api.dart';
import 'dart:ui';
import 'DetailPersonnage_histoire.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ComicDetailsPage extends StatefulWidget {
  final dynamic comic;

  const ComicDetailsPage({Key? key, required this.comic}) : super(key: key);

  @override
  _ComicDetailsPageState createState() => _ComicDetailsPageState();
}

class _ComicDetailsPageState extends State<ComicDetailsPage> {
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
                                  comic['story_arc_credits'] ?? "N/A",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Année de sortie : ${comic['start_year'] ?? 'N/A'}',
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
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.orange, width: 4), // Define the bottom border here
                    ),
                  ),
                  child: Text(
                    'Description',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Rectangle behind description
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3243),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 25.0, left: 27.0, bottom: 8.0, right: 27.0),
                  child: HtmlWidget(
                    comic['description'] ?? 'N/A',
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
