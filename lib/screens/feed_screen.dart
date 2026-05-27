import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/articulo.dart';
import 'articulo_detalle_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = ['Paisaje', 'Playas', 'Cultural', 'Hoteles'];

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
      'description': 'La ciudad de la eterna primavera te cautivará con su cultura, arte, gastronomía y la famosa comuna 13 llena de coloridas historias.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(child: _buildMapCard()),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),
            SliverToBoxAdapter(child: _buildCategoryFilter()),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),
            SliverToBoxAdapter(child: _buildRecommendedTitle()),
            SliverToBoxAdapter(child: const SizedBox(height: 16)),
            SliverToBoxAdapter(child: _buildDestinationGrid()),
            SliverToBoxAdapter(child: const SizedBox(height: 110)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Color(0xFF888888), size: 22),
            Spacer(),
            Icon(Icons.menu, color: Color(0xFF888888), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildMapCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 190,
          child: Image.network(
            'https://maps.googleapis.com/maps/api/staticmap?center=Bogota,Colombia&zoom=12&size=600x400&key=DEMO_KEY',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If static maps API key isn't available, show a styled placeholder
              return Container(
                color: const Color(0xFF2C3E2D),
                child: Stack(
                  children: [
                    // Grid lines to simulate map
                    CustomPaint(
                      painter: _MapPainter(),
                      child: Container(),
                    ),
                    // Central pin
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.location_pin, color: Colors.red, size: 40),
                          SizedBox(height: 4),
                          Text(
                            'Colombia',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _selectedCategoryIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategoryIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? CondorAppTheme.filterIconBg : const Color(0xFF2C2C2C),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF888888),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRecommendedTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        'Recomendado para ti',
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
}

// Custom painter to render a simple map grid in dark mode
class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3A4A3A)
      ..strokeWidth = 0.8;

    // Horizontal lines
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Vertical lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Some "roads" (thicker lines)
    final roadPaint = Paint()
      ..color = const Color(0xFF4A5E4A)
      ..strokeWidth = 3;
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(size.width * 0.35, 0), Offset(size.width * 0.35, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.65, 0), Offset(size.width * 0.65, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
