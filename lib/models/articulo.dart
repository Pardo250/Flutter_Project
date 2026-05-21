class Articulo {
  final String id;
  final String titulo;
  final String descripcion;
  final String tipo;
  final String imagenUrl;

  Articulo({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.tipo,
    this.imagenUrl = '',
  });

  // Método para crear instancias desde JSON
  factory Articulo.fromJson(Map<String, dynamic> json) {
    return Articulo(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descripcion: json['descripcion'] as String,
      tipo: json['tipo'] as String,
      imagenUrl: json['imagenUrl'] as String? ?? '',
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'tipo': tipo,
      'imagenUrl': imagenUrl,
    };
  }
}
