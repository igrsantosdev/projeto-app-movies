import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/movie.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;
  const MovieDetailView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          
          children: [
            Image.network(movie.imageUrl, 
            width: 150, 
            height: 220, 
            fit: BoxFit.cover, 
            errorBuilder: (c,e,s)=> const Icon(Icons.broken_image, size: 64)),

            const SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${movie.title} (${movie.year})',                
                  style: const TextStyle(  
                  fontSize: 18, 
                  fontWeight: FontWeight.bold)),
                  
                  const SizedBox(height: 8),

                  Text('${movie.genre} • ${movie.duration} • ${movie.ageRating}'),

                  const SizedBox(height: 8),
                  
                  RatingBarIndicator(
                    rating: movie.rating,
                    itemBuilder: (_, __) => const Icon(Icons.star, size: 16),
                    itemCount: 5,
                    itemSize: 20.0,
                  ),
                  const SizedBox(height: 12),

                  Flexible(child: SingleChildScrollView(child: Text(movie.description))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}