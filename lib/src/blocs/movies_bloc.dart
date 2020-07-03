import 'package:rxdart/rxdart.dart';
import 'package:themoviedb/src/model/item_model.dart';
import 'package:themoviedb/src/repository/repository.dart';
import 'package:themoviedb/src/blocs/bloc.dart';


class MoviesBloc extends Bloc{
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  searchMoviesQuery(String query) async {
    ItemModel itemModel = await _repository.searchMovies(query);
    _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final moviesListBloc = MoviesBloc();
