import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ComicVineApi {
  static const String _baseUrl = 'https://comicvine.gamespot.com/api/';
  static const String _apiKey = 'b912fd14613c0e92c4e7afe4733d855fb87679cc';//'829aaa23a2400c74edbcf66209e6501a3b2bcc7c';

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

  Future<dynamic> searchMovieByName(String name) async {
    final url = Uri.parse('$_baseUrl/movies/?api_key=$_apiKey&format=json&filter=name:$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['results'];
    } else {
      throw Exception('Erreur lors de la recherche du film');
    }
  }
}

