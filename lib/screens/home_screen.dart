import 'package:flutter/material.dart';
import '../models/articulo.dart';
import '../models/review.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogout;

  const HomeScreen({
    super.key,
    this.onProfileTap,
    this.onLogout,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showFollowingOnly = false;
  bool isLoading = false;
  String? errorMessage;
  int? selectedIndex;

  // Datos de ejemplo
  late List<Articulo> articulos;
  late List<Review> reviews;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    articulos = [
      Articulo(
        id: '1',
        titulo: 'Artículo de prueba 1',
        descripcion: 'Descripción de prueba para el primer artículo',
        tipo: 'cultura',
        imagenUrl: '',
      ),
      Articulo(
        id: '2',
        titulo: 'Artículo de prueba 2',
        descripcion: 'Descripción de prueba para el segundo artículo',
        tipo: 'tecnología',
        imagenUrl: '',
      ),
      Articulo(
        id: '3',
        titulo: 'Artículo de prueba 3',
        descripcion: 'Descripción de prueba para el tercer artículo',
        tipo: 'deportes',
        imagenUrl: '',
      ),
    ];

    reviews = [
      Review(
        id: '1',
        name: 'Juan',
        rating: 5,
        comment: 'Excelente artículo, muy informativo',
        articuloId: '1',
        articuloNombre: 'Artículo de prueba 1',
      ),
      Review(
        id: '2',
        name: 'María',
        rating: 4,
        comment: 'Muy bueno, aunque le faltó más detalle',
        articuloId: '2',
        articuloNombre: 'Artículo de prueba 2',
      ),
    ];
  }

  void _toggleFilter(bool value) {
    setState(() {
      showFollowingOnly = value;
    });
  }

  void _onArticuloClick(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pushNamed(
      context,
      '/articulo_detalle',
      arguments: {
        'articulo': articulos[index],
        'reviews': reviews,
      },
    );
  }

  List<Articulo> get articlesToShow {
    if (showFollowingOnly) {
      final reviewedArticleIds = reviews.map((r) => r.articuloId).toSet();
      return articulos.where((a) => reviewedArticleIds.contains(a.id)).toList();
    }
    return articulos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: HomeHeader(
                onNotifications: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ),
            // Toggle Todos / Siguiendo
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: HomeToggle(
                  showFollowingOnly: showFollowingOnly,
                  onToggle: _toggleFilter,
                ),
              ),
            ),
            // Loading
            if (isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            // Error
            if (errorMessage != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red[700]),
                  ),
                ),
              ),
            // Empty state
            if (showFollowingOnly && articlesToShow.isEmpty && !isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No hay artículos reseñados por los usuarios que sigues aún.',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
            // Articles list
            if (articlesToShow.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final articulo = articlesToShow[index];
                    final originalIndex = articulos.indexOf(articulo);
                    return ArticuloCard(
                      articulo: articulo,
                      isSelected: selectedIndex == originalIndex,
                      onClick: () => _onArticuloClick(originalIndex),
                    );
                  },
                  childCount: articlesToShow.length,
                ),
              ),
            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

/// Header de Home con botón atrás, avatar y notificaciones
class HomeHeader extends StatelessWidget {
  final VoidCallback onNotifications;

  const HomeHeader({
    super.key,
    required this.onNotifications,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withOpacity(0.4),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    customBorder: const CircleBorder(),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.arrow_back,
                        color: colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              // Profile Avatar
              const ProfileAvatar(),
              // Notifications button
              IconButton(
                onPressed: onNotifications,
                icon: Icon(Icons.notifications, color: colorScheme.onSurface),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const FilterBar(),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// Avatar circular del perfil del usuario
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/avatar.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.grey[600],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Barra de filtros con logo y texto
class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 280,
      height: 54,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: colorScheme.primary,
              size: 24,
            ),
            Text(
              'Filtro',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant,
                fontSize: 18,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.2),
              ),
              child: Icon(
                Icons.category,
                color: colorScheme.primary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tarjeta de un artículo del backend con imagen, título, descripción y tipo
class ArticuloCard extends StatelessWidget {
  final Articulo articulo;
  final bool isSelected;
  final VoidCallback onClick;

  const ArticuloCard({
    super.key,
    required this.articulo,
    required this.isSelected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onClick,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
        elevation: isSelected ? 2 : 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (articulo.imagenUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.network(
                  articulo.imagenUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type badge and title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type initial circle
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primary.withOpacity(0.15),
                        ),
                        child: Center(
                          child: Text(
                            articulo.tipo.isNotEmpty
                                ? articulo.tipo[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title and type
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              articulo.titulo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Container(
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: Text(
                                articulo.tipo,
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Description
                  if (articulo.descripcion.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      articulo.descripcion,
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Toggle Todos / Siguiendo para el Home
class HomeToggle extends StatelessWidget {
  final bool showFollowingOnly;
  final Function(bool) onToggle;

  const HomeToggle({
    super.key,
    required this.showFollowingOnly,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _ToggleOption(
            label: 'Todos',
            isSelected: !showFollowingOnly,
            onTap: () => onToggle(false),
            colorScheme: colorScheme,
            testTag: 'home_tab_todos',
          ),
          _ToggleOption(
            label: 'Siguiendo',
            isSelected: showFollowingOnly,
            onTap: () => onToggle(true),
            colorScheme: colorScheme,
            testTag: 'home_tab_siguiendo',
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final String testTag;

  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
    required this.testTag,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tarjeta compacta de review para el feed del Home
class ReviewCardHome extends StatelessWidget {
  final Review review;

  const ReviewCardHome({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.surface,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar, name, rating
            Row(
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary.withOpacity(0.15),
                  ),
                  child: Center(
                    child: Text(
                      review.name.isNotEmpty ? review.name[0] : '?',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Name and article
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (review.articuloNombre.isNotEmpty)
                        Text(
                          'en ${review.articuloNombre}',
                          style: TextStyle(
                            color: colorScheme.outline,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                // Stars
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
            // Comment
            if (review.comment.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                review.comment,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
