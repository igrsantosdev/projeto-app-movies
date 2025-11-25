import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/db_service.dart';

class MovieController extends ChangeNotifier {
  List<Movie> movies = [];
  bool loading = false;

  MovieController() {
    loadMovies();
  }

  Future loadMovies() async {
    loading = true;
    notifyListeners();
    movies = await DBService.instance.getAllMovies();
    loading = false;
    notifyListeners();
  }

  Future addMovie(Movie movie) async {
    await DBService.instance.insertMovie(movie);
    await loadMovies();
  }

  Future updateMovie(Movie movie) async {
    await DBService.instance.updateMovie(movie);
    await loadMovies();
  }

  Future deleteMovie(int id) async {
    await DBService.instance.deleteMovie(id);
    await loadMovies();
  }
}
