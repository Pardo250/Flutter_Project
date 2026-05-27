import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/articulo.dart';
import '../models/review.dart';
import 'articulo_detalle_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _destinations = [
    {
      'id': '1',
      'name': 'Cartagena',
      'img': 'assets/images/cartagena.png',
      'rating': 5,
      'description': 'Descubre la magia de Cartagena, una ciudad colonial llena de historia, playas hermosas y arquitectura impresionante en la costa caribeña de Colombia.',
      'type': 'Cultural',
    },
    {
      'id': '2',
      'name': 'Valle del Cocora',
      'img': 'assets/images/cocora.png',
      'rating': 5,
      'description': 'El Valle del Cocora te sorprenderá con sus imponentes palmas de cera, las más altas del mundo. Un destino imprescindible para amantes de la naturaleza.',
      'type': 'Paisaje',
    },
    {
      'id': '3',
      'name': 'Santa Marta',
      'img': 'assets/images/santa_marta.png',
      'rating': 4,
      'description': 'Santa Marta ofrece playas de arena blanca, acceso a la Ciudad Perdida y una experiencia perfecta para combinar playa y aventura.',
      'type': 'Playas',
    },
    {
      'id': '4',
      'name': 'Medellín',
      'img': 'assets/images/medellin.png',
      'rating': 4,
      'description': 'La ciudad de la eterna primavera te cautivarà con su cultura, arte, gastronomía y la famosa comuna 13 llena de coloridas historias.',
      'type': 'Cultural',
    },
    {
      'id': '5',
      'name': 'Tayrona',
      'img': 'assets/images/tayrona.png',
      'rating': 5,
      'description': 'El Parque Natural Tayrona combina selva tropical con playas paradisíacas, ofreciendo una experiencia única de la naturaleza colombiana.',
      'type': 'Paisaje',
    },
    {
      'id': '6',
      'name': 'Bogotá',
      'img': 'assets/images/bogota.png',
      'rating': 4,
      'description': 'Capital multicultural de Colombia con museos de clase mundial, gastronomía exquisita y una vibra urbana única en los Andes.',
      'type': 'Cultural',
    },
  ];

  final List<Review> _userReviews = [
    Review(
      id: '1',
      name: 'María Valén',
      rating: 5,
      comment: 'La experiencia en Santa Marta fue increíble',
      articuloId: '3',
      articuloNombre: 'Santa Marta',
    ),
    Review(
      id: '2',
      name: 'María Valén',
      rating: 4,
      comment: 'Cartagena hermosa pero algo turística',
      articuloId: '2',
      articuloNombre: 'Cartagena',
    ),
    Review(
      id: '3',
      name: 'María Valén',
      rating: 5,
      comment: 'Tayrona es un lugar mágico',
      articuloId: '5',
      articuloNombre: 'Tayrona',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: _buildTitle()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: _buildDestinationsTitle()),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(child: _buildDestinationGrid()),
            SliverToBoxAdapter(child: const SizedBox(height: 30)),
            SliverToBoxAdapter(child: _buildCommentsTitle()),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dest = _destinations[index];
                  final destReviews = _userReviews
                      .where((r) => r.articuloNombre == dest['name'])
                      .toList();
                  
                  if (destReviews.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  
                  return Column(
                    children: [
                      _buildDestinationCommentsSection(dest, destReviews),
                    ],
                  );
                },
                childCount: _destinations.length,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: CondorAppTheme.filterIconBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const Icon(Icons.notifications_none, color: Colors.white, size: 28),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descubre',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Sitios populares y comentarios',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: CondorAppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationsTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Destinos Recomendados',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildDestinationGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _destinations.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final dest = _destinations[index];
          return _buildDestinationItem(dest);
        },
      ),
    );
  }

  Widget _buildDestinationItem(Map<String, dynamic> dest) {
    return GestureDetector(
      onTap: () {
        final articulo = Articulo(
          id: dest['id'] as String,
          titulo: dest['name'] as String,
          descripcion: dest['description'] as String,
          tipo: dest['type'] as String,
          imagenUrl: dest['img'] as String,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticuloDetalleScreen(
              articulo: articulo,
              reviews: const [],
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                dest['img'] as String,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stack) => Container(
                  color: const Color(0xFF2C2C2C),
                  child: const Icon(Icons.image_not_supported, color: Color(0xFF555555)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            dest['name'] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return Icon(
                Icons.star,
                size: 12,
                color: i < (dest['rating'] as int)
                    ? CondorAppTheme.accentGold
                    : const Color(0xFF555555),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Comentarios por Sitio',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildDestinationCommentsSection(
    Map<String, dynamic> destination,
    List<Review> reviews,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    destination['img'] as String,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      width: 60,
                      height: 60,
                      color: const Color(0xFF2C2C2C),
                      child: const Icon(Icons.image, color: Color(0xFF555555)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: index < (destination['rating'] as int)
                                ? CondorAppTheme.accentGold
                                : const Color(0xFF505050),
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: reviews
                  .map((review) => _buildReviewItem(review))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    color: index < review.rating
                        ? CondorAppTheme.accentGold
                        : const Color(0xFF505050),
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            review.comment,
            style: const TextStyle(
              color: CondorAppTheme.textSecondary,
              fontSize: 13,
            ),
          ),
          if (review != _userReviews.last)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Divider(
                color: const Color(0xFF3A3A3A),
                height: 1,
              ),
            ),
        ],
      ),
    );
  }
}
