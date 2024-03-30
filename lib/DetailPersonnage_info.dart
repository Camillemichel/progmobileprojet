import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DetailPersonnage_histoire.dart';


class DetailPersonnage_Infos extends StatelessWidget {

  final String personnagesName;
  final String personnagesImage;

  DetailPersonnage_Infos({required this.personnagesName, required this.personnagesImage});

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
            height: 812,
            color: Theme.of(context).colorScheme.background,
            child: Stack(
              children: [
                PersonnageImage(personnagesImage: personnagesImage),
                PersonnageInfos(personnageName: personnagesName, personnageImage: personnagesImage),
                Positioned(
                  left: 79,
                  top: 76,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPersonnage_histoire(
                            personnagesName: personnagesName,
                            personnagesImage: personnagesImage,
                          ),
                        ),
                      );
                    },
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
                ),
                Positioned(
                  left: 213,
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
class PersonnageInfos extends StatefulWidget {
  final String personnageName;
  final String personnageImage;

  PersonnageInfos({
    required this.personnageName,
    required this.personnageImage,
  });

  @override
  _PersonnageInfosState createState() => _PersonnageInfosState();
}

class _PersonnageInfosState extends State<PersonnageInfos> {
  final Categorie = [
    'Nom réel:',
    'alias :',
    'Createur:',
    'origine:',
    'genre :',
    'Date de naissance:'
  ];
  List<Map<String, dynamic>> res = [];

  @override
  void initState() {
    super.initState();
    fetchCharacterInfos(widget.personnageName);
  }

  Future<void> fetchCharacterInfos(String personnageName) async {
    final apiKey = 'b912fd14613c0e92c4e7afe4733d855fb87679cc';

    final fields = [
      'real_name',
      'aliases',
      'publisher',
      'origin',
      'gender',
      'birth'
    ];

    // Construct API URLs dynamically
    final apiUrls = fields.map((field) =>
    "https://comicvine.gamespot.com/api/characters/?api_key=$apiKey&format=json&filter=name:$personnageName&field_list=$field")
        .toList();

    for (final apiUrl in apiUrls) {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final results = data['results'];

          if (results == null) {
            res.add({"info": "info non disponible"});
            continue;
          }

          if (results.isNotEmpty) {
            final characterInfo = results[0];
            final formattedInfo = <String, dynamic>{};

            for (var entry in characterInfo.entries) {
              final key = entry.key;
              var value = entry.value;

              // Perform specific transformations based on the key
              switch (key) {
                case 'aliases':
                  value = value ?? "infos non disponibles";
                  break;
                case 'publisher':
                  value = value['name'] ?? "infos non disponibles";
                  break;
                case 'origin':
                  value = value['name'] ?? "infos non disponibles";
                  break;
                case 'gender':
                  value =
                  value == 1 ? 'male' : 'female'; // Assuming 1 represents male
                  break;
                case 'birth':
                  value = value ??
                      "infos non disponibles"; // If null, set to "pas de donnée"
                  break;
                default:
                // For other keys, keep the value as it is
                  break;
              }

              formattedInfo[key] = value;
            }

            res.add(formattedInfo);
          }
        } else {
          print('Failed to fetch data: ${response.statusCode}');
        }
      } catch (e) {
        print("Error occurred while fetching character info: $e");
      }
    }
    print(res);
    setState(() {}); // Trigger widget rebuild after data fetch
  }

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
          left: 54,
          top: 24,
          child: Container(
            width: 188,
            height: 26,
            child: Text(
              widget.personnageName,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ),
        Positioned(
          left: 23,
          top: 128,
          child: Container(
            width: 162,
            height: 23,
            child: Text(
              "Nom du personnage",
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ),
        Positioned(
          left: 213,
          top: 128,
          child: Container(
            width: 109,
            height: 23,
            child: Text(
              widget.personnageName,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ),
        if (res.isEmpty) // Afficher le indicateur de chargement si res est vide
          Positioned(
            left: 200,
            top: 200,
            child: CircularProgressIndicator(),
          ),
        for (int i = 0; i < Categorie.length; i++)
          Positioned(
            left: 23,
            top: (21 + 23) * i + 172,
            child: Container(
              width: 145,
              height: 23,
              child: Text(
                Categorie[i],
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
        for (int i = 0; i < res.length; i++)
          Positioned(
            left: 213,
            top: (21 + 23) * i + 172,
            child: Container(
              width: 180,
              height: 23,
              child: Text(
                res[i].values.first, // Accessing the first value of the Map
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
