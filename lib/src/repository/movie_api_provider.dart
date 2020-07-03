import 'package:http/http.dart' show Client, Response;
import 'dart:async';
import 'dart:convert';

import 'package:themoviedb/src/model/item_model.dart';
import 'package:themoviedb/src/model/trailer_model.dart';



class ApiProvider{
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList() async {
    Response response;
    if(_apiKey != '') {
       response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    }else{
      throw Exception('Please add your API key');
    }
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> searchMovies(String query) async {
    Response response;
    if(_apiKey != '') {
      String url = query.length > 0 ? "https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=$query" : 
                  "$_baseUrl/popular?api_key=$_apiKey";
       response = await client.get(url);
    }else{
      throw Exception('Please add your API key');
    }
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}