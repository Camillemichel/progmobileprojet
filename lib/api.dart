import 'package:http/http.dart' as http;
import 'dart:convert';


class ComicVineApi {
  static const String _baseUrl = 'https://comicvine.gamespot.com/api/';
  static const String _apiKey = '6db50ee6d46842bad12ce3ecbf244c7aae2f9041';

  Future<dynamic> getData(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint?api_key=$_apiKey&format=json&limit=4');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Erreur lors de la récupération des données');
    }
  }

  Future<dynamic> searchMovieByName(int id) async {
    print("id :");
    print(id);
    final url = Uri.parse('https://comicvine.gamespot.com/api/movie/4025-${id.toString()}/?api_key=6db50ee6d46842bad12ce3ecbf244c7aae2f9041&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Erreur lors de la recherche du film');
    }
  }

  Future<dynamic> searchSerieByName(int id) async {
    print("id :");
    print(id);
    final url = Uri.parse('https://comicvine.gamespot.com/api/series/4075-${id.toString()}/?api_key=6db50ee6d46842bad12ce3ecbf244c7aae2f9041&format=json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Erreur lors de la recherche de la serie');
    }
  }

  Future<dynamic> searchEpisodeByName(int id) async {
    print("OKKK IDDD :" + id.toString());
    final url = Uri.parse('https://comicvine.gamespot.com/api/episode/4070-$id/?api_key=$_apiKey&format=json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Erreur lors de la recherche de l episode');
    }
  }

}

//https://comicvine.gamespot.com/api/episode/4070-1/ EPISODE POUR LA SERIE 1



