import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DetailPersonnage_info.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
      home: DetailPersonnage_histoire(personnagesName: "",personnagesImage: ""),
    );
  }
}

class DetailPersonnage_histoire extends StatelessWidget {
  final String personnagesName;
  final String personnagesImage;

  DetailPersonnage_histoire({required this.personnagesName, required this.personnagesImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 375,
          height: 3570,
          color: Theme.of(context).colorScheme.background,
          child: Stack(
            children: [
              PersonnageImage(personnagesImage: personnagesImage),
              PersonnageHistoire(personnageName: personnagesName, personnageImage: personnagesImage),
              Positioned(
                left: 79,
                top: 76,
                child: Container(
                  width: 57,
                  height: 22,
                  child: Text(
                    "Histoire",
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 54,
                top: 103,
                child: Container(
                  width: 108,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 248.5,
                top: 76,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPersonnage_Infos(
                          personnagesName: personnagesName,
                          personnagesImage: personnagesImage,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 36,
                    height: 22,
                    child: Text(
                      "Infos",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonnageImage extends StatelessWidget {

  final String personnagesImage;

  PersonnageImage({required this.personnagesImage});
   @override
   Widget build(BuildContext context) {
    return Stack(
        children: [
          Positioned(
            left: 0.5,
            top: -230.73,
            child: Container(
              width: 391.43,
              height: 703,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(21, 35, 46, 0.7), // Couleur du dégradé avec alpha
                    Colors.transparent, // Couleur transparente à la fin du dégradé
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Couleur du flou
                    blurRadius: 2, // Rayon du flou
                  ),
                ],
              ),
              child: Image.network(
                personnagesImage, // URL de l'image
              ),
              ),
          ),
          Positioned(
            left: 24,
            top: 28,
           child: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Retour en arrière lorsque l'image est tapée
             },
            child: SvgPicture.asset(
              'assets/theicons.co.svg',
              width: 12,
              height: 18,
            ),
           ),
          ),
        ]
    );
  }
}
class PersonnageHistoire extends StatelessWidget {

  final String personnageName;
  final String personnageImage;
  PersonnageHistoire({required this.personnageName,required this.personnageImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 107,
          child: Container(
            width: 375,
            height: 3470,
            decoration: BoxDecoration(
              color: Color.fromRGBO(30, 50, 67, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
        Positioned(
          left:54,
          top:24,
          child: Container(
            width: 188,
            height: 26,
            child: Text(
              personnageName,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            )
          )
        ),
        Positioned(
          left: 27,
          top: 132,
          child: Container(
            width: 321,
            height: 3470,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                FutureBuilder<String?>(
                  future: fetchCharacterHistory(personnageName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return HtmlWidget(snapshot.data ?? 'Aucune histoire disponible');
                    } else {
                      return Text('Aucune donnée disponible');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<String?> fetchCharacterHistory(String personnageName) async {
    final apiKey = 'b912fd14613c0e92c4e7afe4733d855fb87679cc';
    final apiUrl =
        "https://comicvine.gamespot.com/api/characters/?api_key=${apiKey}&format=json&filter=name:${personnageName}&field_list=description";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'];

        if (results != null && results.isNotEmpty) {
          final characterHistory = results[0]['description'];
          return characterHistory;
        }
      }
    } catch (e) {
      print("Erreur lors de la récupération de l'histoire du personnage: $e");
    }

    return null;
  }
}
