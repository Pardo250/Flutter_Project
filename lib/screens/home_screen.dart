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
  int _selectedNavIndex = 1; // Home is selected by default

  final List<Map<String, dynamic>> _posts = [
    {
      'id': '1',
      'author': 'Alejandra Gomez',
      'location': 'Valle del Cocora',
      'img': 'assets/images/cocora.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
      'likes': 1200,
      'comments': 48,
    },
    {
      'id': '2',
      'author': 'Mateo Ruiz',
      'location': 'Cartagena Old City',
      'img': 'assets/images/cartagena.png',
      'description': 'Una experiencia increíble en el corazón histórico de Cartagena',
      'likes': 956,
      'comments': 32,
    },
    {
      'id': '3',
      'author': 'María Valén',
      'location': 'Santa Marta',
      'img': 'assets/images/santa_marta.png',
      'description': 'Las mejores vistas del caribe colombiano',
      'likes': 1543,
      'comments': 67,
    },
    {
      'id': '4',
      'author': 'Juan García',
      'location': 'Medellín',
      'img': 'assets/images/medellin.png',
      'description': 'Descubriendo la ciudad de la eterna primavera',
      'likes': 876,
      'comments': 24,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Profile Avatar and Filter
            SliverToBoxAdapter(
              child: _buildProfileHeader(),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            // Posts List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildPostCard(_posts[index]);
                },
                childCount: _posts.length,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 100)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CondorAppTheme.filterIconBg,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 16),
          // Filter Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: CondorAppTheme.filterIconBg,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.tune, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Filtro',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return GestureDetector(
      onTap: () {
        // Create articulo from post data
        final articulo = Articulo(
          id: post['id'] as String,
          titulo: post['location'] as String,
          descripcion: post['description'] as String,
          tipo: 'Reseña',
          imagenUrl: post['img'] as String,
        );
        
        // Navigate to detail screen
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF242424),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3A3A3A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post['location'] as String,
                        style: const TextStyle(
                          color: CondorAppTheme.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Post Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                post['img'] as String,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  width: double.infinity,
                  height: 250,
                  color: const Color(0xFF2C2C2C),
                  child: const Icon(Icons.image_not_supported, color: Color(0xFF555555)),
                ),
              ),
            ),
            // Description
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                post['description'] as String,
                style: const TextStyle(
                  color: CondorAppTheme.textSecondary,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            // Likes and Comments
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '${post['likes']}k',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '${post['comments']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        border: Border(
          top: BorderSide(color: const Color(0xFF3A3A3A)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedNavIndex,
          onTap: (index) {
            setState(() {
              _selectedNavIndex = index;
            });
          },
          selectedItemColor: CondorAppTheme.filterIconBg,
          unselectedItemColor: CondorAppTheme.textSecondary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
