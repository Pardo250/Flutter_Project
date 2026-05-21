import 'package:flutter/material.dart';
import '../models/profile_ui_state.dart';
import '../models/review.dart';
import '../models/articulo.dart';
import '../theme/app_theme.dart';
import '../widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileUiState uiState;
  int? editingReviewId;

  @override
  void initState() {
    super.initState();
    _initializeProfileData();
  }

  void _initializeProfileData() {
    uiState = ProfileUiState(
      name: 'Juan Pérez',
      username: '@juanperez',
      imageUrl: '',
      followersCount: 150,
      followingCount: 42,
      isTopReviewer: true,
      isInfluencer: false,
      reviews: [
        Review(
          id: '1',
          name: 'Juan',
          rating: 5,
          comment: 'Valle del Cocora es un lugar hermoso con vistas impresionantes.',
          articuloId: '1',
          articuloNombre: 'Valle del Cocora',
        ),
        Review(
          id: '2',
          name: 'Juan',
          rating: 4,
          comment: 'Playa Blanca tiene arena suave pero estaba un poco llena.',
          articuloId: '2',
          articuloNombre: 'Playa Blanca',
        ),
        Review(
          id: '3',
          name: 'Juan',
          rating: 5,
          comment: 'Centro histórico hermoso, arquitectura bien conservada.',
          articuloId: '3',
          articuloNombre: 'Centro Histórico',
        ),
      ],
      savedArticles: [
        Articulo(
          id: '1',
          titulo: 'Montañas Nevadas',
          descripcion: 'Picos blancos y nieve perpetua',
          tipo: 'paisaje',
        ),
        Articulo(
          id: '2',
          titulo: 'Catedral Metropolitana',
          descripcion: 'Monumento arquitectónico religioso',
          tipo: 'cultural',
        ),
        Articulo(
          id: '3',
          titulo: 'Resort de Lujo',
          descripcion: 'Hotel 5 estrellas frente al mar',
          tipo: 'hotel',
        ),
      ],
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      uiState = uiState.copyWith(isShowingSaved: index == 1);
    });
  }

  void _startEditReview(Review review) {
    setState(() {
      editingReviewId = int.tryParse(review.id);
      uiState = uiState.copyWith(
        isEditingReview: true,
        editComment: review.comment,
        editRating: review.rating,
      );
    });
  }

  void _onEditCommentChange(String value) {
    setState(() {
      uiState = uiState.copyWith(editComment: value);
    });
  }

  void _onEditRatingChange(int rating) {
    setState(() {
      uiState = uiState.copyWith(editRating: rating);
    });
  }

  void _confirmEditReview() {
    if (editingReviewId != null) {
      final reviewIndex =
          uiState.reviews.indexWhere((r) => r.id == editingReviewId.toString());
      if (reviewIndex != -1) {
        final updatedReview = Review(
          id: uiState.reviews[reviewIndex].id,
          name: uiState.reviews[reviewIndex].name,
          rating: uiState.editRating,
          comment: uiState.editComment,
          articuloId: uiState.reviews[reviewIndex].articuloId,
          articuloNombre: uiState.reviews[reviewIndex].articuloNombre,
        );

        final updatedReviews = List<Review>.from(uiState.reviews);
        updatedReviews[reviewIndex] = updatedReview;

        setState(() {
          uiState = uiState.copyWith(
            reviews: updatedReviews,
            isEditingReview: false,
          );
          editingReviewId = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reseña actualizada correctamente')),
        );
      }
    }
  }

  void _cancelEditReview() {
    setState(() {
      uiState = uiState.copyWith(isEditingReview: false);
      editingReviewId = null;
    });
  }

  void _deleteReview(String reviewId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Reseña'),
          content: const Text('¿Estás seguro de que deseas eliminar esta reseña?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  uiState = uiState.copyWith(
                    reviews: uiState.reviews
                        .where((r) => r.id != reviewId)
                        .toList(),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reseña eliminada')),
                );
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Stack(
          children: [
            // Contenido principal
            ProfileScreenContent(
              state: uiState,
              onBack: () => Navigator.pop(context),
              onEditProfile: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ir a editar perfil')),
                );
              },
              onShareProfile: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Compartir perfil')),
                );
              },
              onEditReview: _startEditReview,
              onDeleteReview: _deleteReview,
              onFollowListClick: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ver lista de seguidores')),
                );
              },
              onTabSelected: _onTabSelected,
            ),
            // Diálogo de edición
            if (uiState.isEditingReview)
              EditReviewDialog(
                comment: uiState.editComment,
                rating: uiState.editRating,
                onCommentChange: _onEditCommentChange,
                onRatingChange: _onEditRatingChange,
                onConfirm: _confirmEditReview,
                onDismiss: _cancelEditReview,
              ),
          ],
        ),
      ),
    );
  }
}

/// Contenido stateless de la pantalla de perfil
class ProfileScreenContent extends StatelessWidget {
  final ProfileUiState state;
  final VoidCallback onBack;
  final VoidCallback onEditProfile;
  final VoidCallback onShareProfile;
  final Function(Review) onEditReview;
  final Function(String) onDeleteReview;
  final VoidCallback onFollowListClick;
  final Function(int) onTabSelected;

  const ProfileScreenContent({
    super.key,
    required this.state,
    required this.onBack,
    required this.onEditProfile,
    required this.onShareProfile,
    required this.onEditReview,
    required this.onDeleteReview,
    required this.onFollowListClick,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
            onPressed: onBack,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: colorScheme.onBackground),
              onPressed: () {},
            ),
          ],
        ),
        // Profile Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ProfileHeader(
                  name: state.name,
                  username: state.username,
                  imageUrl: state.imageUrl,
                  followersCount: state.followersCount,
                  followingCount: state.followingCount,
                  isTopReviewer: state.isTopReviewer,
                  isInfluencer: state.isInfluencer,
                  onFollowListClick: onFollowListClick,
                ),
                const SizedBox(height: 24),
                ProfileActions(
                  onEditProfile: onEditProfile,
                  onShareProfile: onShareProfile,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        // Tabs
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DefaultTabController(
              length: 2,
              initialIndex: state.isShowingSaved ? 1 : 0,
              child: Column(
                children: [
                  TabBar(
                    onTap: onTabSelected,
                    indicatorColor: colorScheme.primary,
                    labelColor: colorScheme.primary,
                    unselectedLabelColor: colorScheme.outline,
                    tabs: const [
                      Tab(text: 'Mis Reseñas'),
                      Tab(text: 'Guardados'),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
        // Loading
        if (state.isLoading)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: CircularProgressIndicator(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        // Error
        if (state.errorMessage != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                state.errorMessage!,
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          ),
        // Reviews
        if (!state.isShowingSaved)
          if (state.reviews.isEmpty && !state.isLoading)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Aún no has hecho reseñas.',
                  style: TextStyle(color: colorScheme.outline),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final review = state.reviews[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyReviewItem(
                      review: review,
                      onEdit: () => onEditReview(review),
                      onDelete: () => onDeleteReview(review.id),
                    ),
                  );
                },
                childCount: state.reviews.length,
              ),
            ),
        // Saved Articles
        if (state.isShowingSaved)
          if (state.savedArticles.isEmpty && !state.isLoading)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'No tienes artículos guardados.',
                  style: TextStyle(color: colorScheme.outline),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final articulo = state.savedArticles[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: colorScheme.surfaceVariant,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articulo.titulo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              articulo.tipo,
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: state.savedArticles.length,
              ),
            ),
        // Bottom padding
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}

/// Header del perfil con avatar, nombre, username y contadores sociales
class ProfileHeader extends StatelessWidget {
  final String name;
  final String username;
  final String? imageUrl;
  final int followersCount;
  final int followingCount;
  final bool isTopReviewer;
  final bool isInfluencer;
  final VoidCallback onFollowListClick;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.username,
    this.imageUrl,
    required this.followersCount,
    required this.followingCount,
    this.isTopReviewer = false,
    this.isInfluencer = false,
    required this.onFollowListClick,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImage(imageUrl: imageUrl),
        const SizedBox(height: 16),
        // Name and badges
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            if (isTopReviewer) ...[
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFD700).withOpacity(0.2),
                  border: Border.all(
                    color: const Color(0xFFFFD700),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.star,
                  color: Color(0xFFFFD700),
                  size: 18,
                ),
              ),
            ],
            if (isInfluencer) ...[
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2196F3).withOpacity(0.2),
                  border: Border.all(
                    color: const Color(0xFF2196F3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.verified,
                  color: Color(0xFF2196F3),
                  size: 18,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          username,
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.outline,
          ),
        ),
        const SizedBox(height: 16),
        // Followers/Following
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onFollowListClick,
              child: Column(
                children: [
                  Text(
                    '$followersCount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    'Seguidores',
                    style: TextStyle(
                      color: colorScheme.outline,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
            GestureDetector(
              onTap: onFollowListClick,
              child: Column(
                children: [
                  Text(
                    '$followingCount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    'Siguiendo',
                    style: TextStyle(
                      color: colorScheme.outline,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Botones de acción del perfil: editar y compartir
class ProfileActions extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onShareProfile;

  const ProfileActions({
    super.key,
    required this.onEditProfile,
    required this.onShareProfile,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onEditProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Editar Perfil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: onShareProfile,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Compartir',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

/// Ítem de reseña propia con calificación, comentario y botones de editar/eliminar
class MyReviewItem extends StatelessWidget {
  final Review review;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MyReviewItem({
    super.key,
    required this.review,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surface,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artículo nombre
            if (review.articuloNombre.isNotEmpty) ...[
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(
                  '📌 ${review.articuloNombre}',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
            // Header con ícono y rating
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary.withOpacity(0.15),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reseña #${review.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 14,
                            color: index < review.rating
                                ? CondorAppTheme.condorStarActive
                                : colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Comentario
            Text(
              review.comment,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            // Botones editar/eliminar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Editar', fontSize: 12),
                ),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, size: 16, color: Colors.red),
                  label: const Text('Eliminar', fontSize: 12),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Diálogo para editar una review existente
class EditReviewDialog extends StatefulWidget {
  final String comment;
  final int rating;
  final Function(String) onCommentChange;
  final Function(int) onRatingChange;
  final VoidCallback onConfirm;
  final VoidCallback onDismiss;

  const EditReviewDialog({
    super.key,
    required this.comment,
    required this.rating,
    required this.onCommentChange,
    required this.onRatingChange,
    required this.onConfirm,
    required this.onDismiss,
  });

  @override
  State<EditReviewDialog> createState() => _EditReviewDialogState();
}

class _EditReviewDialogState extends State<EditReviewDialog> {
  late TextEditingController _commentController;
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController(text: widget.comment);
    _currentRating = widget.rating;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: const Text(
        'Editar Reseña',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calificación',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      _currentRating = index + 1;
                      widget.onRatingChange(_currentRating);
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < _currentRating
                        ? CondorAppTheme.condorStarActive
                        : colorScheme.outlineVariant,
                    size: 28,
                  ),
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Comentario',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              onChanged: widget.onCommentChange,
              decoration: InputDecoration(
                hintText: 'Escribe tu reseña...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onDismiss,
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: widget.onConfirm,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
