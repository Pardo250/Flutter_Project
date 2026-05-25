import 'package:flutter/material.dart';
import '../models/review.dart';
import '../models/profile_ui_state.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileUiState profileState;

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  void _initializeProfile() {
    profileState = ProfileUiState(
      name: 'María Valén',
      username: '@mariaval',
      followersCount: 1024,
      followingCount: 342,
      reviews: [
        Review(
          id: '1',
          name: 'María Valén',
          rating: 5,
          comment: 'La experiencia en Santa Marta fue increíble',
          articuloId: '1',
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
          articuloId: '3',
          articuloNombre: 'Tayrona',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CondorAppTheme.darkBg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildProfileHeader(),
            ),
            SliverToBoxAdapter(
              child: _buildStatsGrid(),
            ),
            SliverToBoxAdapter(
              child: _buildActionButtons(),
            ),
            SliverToBoxAdapter(
              child: _buildReviewsTitle(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildReviewCard(context, profileState.reviews[index]),
                childCount: profileState.reviews.length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Large Avatar
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  CondorAppTheme.primaryGreen.withValues(alpha: 0.5),
                  CondorAppTheme.accentBrown.withValues(alpha: 0.5),
                ],
              ),
              border: Border.all(color: CondorAppTheme.primaryGreen, width: 3),
            ),
            child: const Center(
              child: Text('👤', style: TextStyle(fontSize: 60)),
            ),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            profileState.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: CondorAppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          // Username
          Text(
            profileState.username,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CondorAppTheme.textSecondary,
                ),
          ),
          const SizedBox(height: 12),
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: CondorAppTheme.accentGold.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: CondorAppTheme.accentGold),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(
                  'Top Reviewers',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CondorAppTheme.accentGold,
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

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(context, '${profileState.followersCount}', 'Seguidores'),
          _buildStatItem(context, '${profileState.followingCount}', 'Siguiendo'),
          _buildStatItem(context, '${profileState.reviews.length}', 'Reseñas'),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CondorAppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: CondorAppTheme.textTertiary,
              ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            label: const Text('Editar Perfil'),
            style: ElevatedButton.styleFrom(
              backgroundColor: CondorAppTheme.primaryGreen,
              foregroundColor: CondorAppTheme.darkGreen,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar Sesión'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        'Mis Reseñas',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: CondorAppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CondorAppTheme.cardBg,
          border: Border.all(color: const Color(0xFF404040)),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.articuloNombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: CondorAppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index < review.rating
                              ? CondorAppTheme.accentGold
                              : const Color(0xFF505050),
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${review.rating}.0',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CondorAppTheme.accentGold,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CondorAppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
