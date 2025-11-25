import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/movie.dart';
import '../controllers/movie_controller.dart';

class MovieFormView extends StatefulWidget {
  final Movie? movie;
  const MovieFormView({super.key, this.movie});

  @override
  State<MovieFormView> createState() => _MovieFormViewState();
}

class _MovieFormViewState extends State<MovieFormView> {
  final _formKey = GlobalKey<FormState>();
  final MovieController controller = MovieController();

  late TextEditingController _titleC;
  late TextEditingController _imageC;
  late TextEditingController _genreC;
  late TextEditingController _durationC;
  late TextEditingController _yearC;
  late TextEditingController _descC;
  String _age = 'Livre';
  double _rating = 0;

  @override
  void initState() {
    super.initState();
    final m = widget.movie;
    _titleC = TextEditingController(text: m?.title ?? '');
    _imageC = TextEditingController(text: m?.imageUrl ?? '');
    _genreC = TextEditingController(text: m?.genre ?? '');
    _durationC = TextEditingController(text: m?.duration ?? '');
    _yearC = TextEditingController(text: m?.year?.toString() ?? '');
    _descC = TextEditingController(text: m?.description ?? '');
    _age = m?.ageRating ?? 'Livre';
    _rating = m?.rating ?? 0;
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final movie = Movie(
      id: widget.movie?.id,
      imageUrl: _imageC.text,
      title: _titleC.text,
      genre: _genreC.text,
      ageRating: _age,
      duration: _durationC.text,
      rating: _rating,
      description: _descC.text,
      year: int.tryParse(_yearC.text) ?? 0,
    );
    if (widget.movie == null) {
      await controller.addMovie(movie);
    } else {
      await controller.updateMovie(movie);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie == null ? 'Cadastrar Filme' : 'Alterar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
              controller: _imageC,
              decoration: const InputDecoration(labelText: 'URL da imagem'),
              validator: (v) => v==null || v.isEmpty ? 'Informe a URL da imagem' : null,
            ),
            TextFormField(
              controller: _titleC,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (v) => v==null || v.isEmpty ? 'Informe o título' : null,
            ),
            TextFormField(
              controller: _genreC,
              decoration: const InputDecoration(labelText: 'Gênero'),
              validator: (v) => v==null || v.isEmpty ? 'Informe o gênero' : null,
            ),
            DropdownButtonFormField<String>(
              value: _age,
              items: const [
                DropdownMenuItem(value: 'Livre', child: Text('Livre')),
                DropdownMenuItem(value: '10', child: Text('10')),
                DropdownMenuItem(value: '12', child: Text('12')),
                DropdownMenuItem(value: '14', child: Text('14')),
                DropdownMenuItem(value: '16', child: Text('16')),
                DropdownMenuItem(value: '18', child: Text('18')),
              ],
              onChanged: (v) => setState(() { _age = v!; }),
              decoration: const InputDecoration(labelText: 'Faixa Etária'),
            ),
            TextFormField(
              controller: _durationC,
              decoration: const InputDecoration(labelText: 'Duração'),
              validator: (v) => v==null || v.isEmpty ? 'Informe a duração' : null,
            ),
            TextFormField(
              controller: _yearC,
              decoration: const InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
              validator: (v) => v==null || v.isEmpty ? 'Informe o ano' : null,
            ),
            const SizedBox(height: 12),
            const Text('Pontuação'),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              maxRating: 5,
              allowHalfRating: true,
              itemBuilder: (context, _) => const Icon(Icons.star),
              onRatingUpdate: (r) => _rating = r,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descC,
              decoration: const InputDecoration(labelText: 'Descrição'),
              maxLines: 5,
              validator: (v) => v==null || v.isEmpty ? 'Informe a descrição' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text('Salvar')),
          ]),
        ),
      ),
    );
  }
}
