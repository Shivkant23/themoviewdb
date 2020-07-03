import 'package:flutter/material.dart';
import 'package:themoviedb/src/blocs/movie_detail_bloc_provider.dart';
import 'package:themoviedb/src/blocs/movies_bloc.dart';
import 'package:themoviedb/src/model/item_model.dart';
import 'package:themoviedb/src/ui/DetailsScreen.dart';
import 'package:themoviedb/src/blocs/bloc_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    moviesListBloc.fetchAllMovies();
    super.initState();
  }

  @override
  void dispose() {
    moviesListBloc.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoviesBloc>(
      bloc : moviesListBloc, 
      child: Scaffold(
        appBar: _appBar(moviesListBloc),
        body: _body(moviesListBloc),
      ),
    );
  }

  Widget _body(moviesListBloc){
    return StreamBuilder(
        stream: moviesListBloc.allMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      );
  }

  Widget buildList(snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data
                    .results[index].poster_path}',
                fit: BoxFit.cover,
              ),
              onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
        });
  }

  openDetailPage(ItemModel data, int index) {
    final page = MovieDetailBlocProvider(
      child: DetailsScreen(
        title: data.results[index].title,
        posterUrl: data.results[index].backdrop_path,
        description: data.results[index].overview,
        releaseDate: data.results[index].release_date,
        voteAverage: data.results[index].vote_average.toString(),
        movieId: data.results[index].id,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }

  _appBar(bloc){
    return AppBar(
      backgroundColor: Colors.purple[800],
      brightness: Brightness.dark,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            "Popular Movies",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Material(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                ),
                suffixIcon: Material(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(
                    Icons.backspace,
                    color: Colors.black45,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                border: InputBorder.none,
              ),
              onChanged: (query) => bloc.searchMoviesQuery(query),
            ),
          ),
        ),
      ),
    );
  }
}