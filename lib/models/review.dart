class Review {
  final String id;
  final String name;
  final int rating;
  final String comment;
  final String articuloId;
  final String articuloNombre;

  Review({
    required this.id,
    required this.name,
    required this.rating,
    required this.comment,
    required this.articuloId,
    required this.articuloNombre,
  });

  // Método para crear instancias desde JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      name: json['name'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String? ?? '',
      articuloId: json['articuloId'] as String,
      articuloNombre: json['articuloNombre'] as String? ?? '',
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'comment': comment,
      'articuloId': articuloId,
      'articuloNombre': articuloNombre,
    };
  }
}
