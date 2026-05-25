import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: _buildAvatar()),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(child: _buildFilterPill()),
            SliverToBoxAdapter(child: const SizedBox(height: 30)),
            SliverList(
              delegate: SliverChildListDelegate([
                _buildFeedCard(
                  authorName: 'Alejandra Gomez',
                  location: 'Valle del Cocora',
                  letter: 'A',
                  imageUrl: 'https://picsum.photos/seed/cocora/600/300',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                  likes: '1.2k',
                  comments: '48',
                ),
                _buildFeedCard(
                  authorName: 'Mateo Ruiz',
                  location: 'Cartagena Old City',
                  letter: 'M',
                  imageUrl: 'https://picsum.photos/seed/cartagena/600/300',
                  description:
                      'Explorando la magia de Cartagena y sus atardeceres espectaculares',
                  likes: '2.5k',
                  comments: '120',
                ),
                const SizedBox(height: 110),
              ]),
            ),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: CondorAppTheme.filterIconBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const Icon(Icons.notifications_none, color: Colors.white, size: 28),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage('https://i.pravatar.cc/150?img=11'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPill() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF3A3A3A)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.menu, color: Colors.white),
            const SizedBox(width: 40),
            const Text(
              'Filtro',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 40),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: CondorAppTheme.filterIconBg,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.eco, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedCard({
    required String authorName,
    required String location,
    required String letter,
    required String imageUrl,
    required String description,
    required String likes,
    required String comments,
  }) {
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
                Text(
                  letter,
                  style: const TextStyle(
                    color: Color(0xFFB39DDB),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        location,
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => Container(
              height: 220,
              color: const Color(0xFF2C2C2C),
              child: const Center(
                child: Icon(Icons.image, color: Color(0xFF555555), size: 60),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFFBBBBBB),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                const Icon(Icons.favorite_border, color: Color(0xFFAAAAAA)),
                const SizedBox(width: 8),
                Text(
                  likes,
                  style: const TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 24),
                const Icon(Icons.chat_bubble, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  comments,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
