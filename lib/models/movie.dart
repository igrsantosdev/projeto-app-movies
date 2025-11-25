class Movie {
  int? id;
  String imageUrl;
  String title;
  String genre;
  String ageRating;
  String duration;
  double rating;
  String description;
  int year;

  Movie({
    this.id,
    required this.imageUrl,
    required this.title,
    required this.genre,
    required this.ageRating,
    required this.duration,
    required this.rating,
    required this.description,
    required this.year,
  });

  factory Movie.fromMap(Map<String, dynamic> map) => Movie(
    id: map['id'] as int?,
    imageUrl: map['imageUrl'] as String,
    title: map['title'] as String,
    genre: map['genre'] as String,
    ageRating: map['ageRating'] as String,
    duration: map['duration'] as String,
    rating: (map['rating'] as num).toDouble(),
    description: map['description'] as String,
    year: map['year'] as int,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'imageUrl': imageUrl,
      'title': title,
      'genre': genre,
      'ageRating': ageRating,
      'duration': duration,
      'rating': rating,
      'description': description,
      'year': year,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
