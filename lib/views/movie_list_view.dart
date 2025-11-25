import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../controllers/movie_controller.dart';
import '../models/movie.dart';
import 'movie_form_view.dart';
import 'movie_detail_view.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({super.key});

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  late MovieController controller;

  @override
  void initState() {
    super.initState();
    controller = MovieController();
  }

  void _showGroupAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Grupo'),
        content: const Text('axl e igor'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }

  void _showOptions(BuildContext ctx, Movie movie) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return SafeArea(child: Wrap(children: [
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Exibir Dados'),
          onTap: () {
            Navigator.pop(ctx);
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => MovieDetailView(movie: movie)));
          },
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Alterar'),
          onTap: () {
            Navigator.pop(ctx);
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => MovieFormView(movie: movie)));
          },
        ),
      ]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes'),
        actions: [
          IconButton(onPressed: _showGroupAlert, icon: const Icon(Icons.info_outline)),
        ],
      ),
      body: FutureBuilder(
        future: controller.loadMovies(),
        builder: (ctx, snap) {
          if (controller.loading) return const Center(child: CircularProgressIndicator());
          if (controller.movies.isEmpty) return const Center(child: Text('Nenhum filme cadastrado'));
          return ListView.builder(
            itemCount: controller.movies.length,
            itemBuilder: (ctx, i) {
              final m = controller.movies[i];
              return Dismissible(
                key: Key(m.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) async {
                  await controller.deleteMovie(m.id!);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filme deletado')));
                  setState(() {});
                },
                child: ListTile(
                  leading: Image.network(m.imageUrl, width: 60, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image)),
                  title: Text(m.title),
                  subtitle: Text('${m.genre} • ${m.year}'),
                  trailing: RatingBarIndicator(
                    rating: m.rating,
                    itemBuilder: (_, __) => const Icon(Icons.star, size: 16),
                    itemCount: 5,
                    itemSize: 18.0,
                    direction: Axis.horizontal,
                  ),
                  onTap: () => _showOptions(context, m),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MovieFormView())).then((_) => setState(() {})),
      ),
    );
  }
}
