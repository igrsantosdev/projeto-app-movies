import 'package:flutter/material.dart';
import 'views/movie_list_view.dart';
import 'services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.instance.initDB();
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies MVC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
