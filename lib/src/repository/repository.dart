
import 'package:themoviedb/src/model/item_model.dart';
import 'package:themoviedb/src/model/trailer_model.dart';
import 'package:themoviedb/src/repository/movie_api_provider.dart';

class Repository{
  final apiProvider =  ApiProvider();
  
  Future<ItemModel> fetchAllMovies() => apiProvider.fetchMovieList();

  Future<ItemModel> searchMovies(String movieString) => apiProvider.searchMovies(movieString);

  Future<TrailerModel> fetchTrailers(int movieId) => apiProvider.fetchTrailer(movieId);
}