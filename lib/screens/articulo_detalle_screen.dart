import 'package:flutter/material.dart';
import '../models/articulo.dart';
import '../models/review.dart';
import '../theme/app_theme.dart';

class ArticuloDetalleScreen extends StatefulWidget {
  final Articulo articulo;
  final List<Review> reviews;

  const ArticuloDetalleScreen({
    super.key,
    required this.articulo,
    this.reviews = const [],
  });

  @override
  State<ArticuloDetalleScreen> createState() => _ArticuloDetalleScreenState();
}

class _ArticuloDetalleScreenState extends State<ArticuloDetalleScreen>
    with TickerProviderStateMixin {
  bool _isSaved = false;
  late List<Review> _reviews;
  bool _showReviewForm = false;
  int _newRating = 5;
  final _commentController = TextEditingController();
  late AnimationController _heartController;
  late AnimationController _fabController;
  late Animation<double> _heartScale;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _reviews = List<Review>.from(widget.reviews);

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heartScale = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.elasticOut),
    );

    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fabAnimation = CurvedAnimation(parent: _fabController, curve: Curves.easeOut);
    _fabController.forward();
  }

  @override
  void dispose() {
    _heartController.dispose();
    _fabController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _toggleSaved() {
    setState(() => _isSaved = !_isSaved);
    _heartController.forward(from: 0.0);
  }

  void _submitReview() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) return;

    final newReview = Review(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Tú',
      rating: _newRating,
      comment: comment,
      articuloId: widget.articulo.id,
      articuloNombre: widget.articulo.titulo,
    );

    setState(() {
      _reviews.insert(0, newReview);
      _showReviewForm = false;
      _newRating = 5;
      _commentController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¡Reseña publicada exitosamente!'),
        backgroundColor: const Color(0xFF90C965),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Color _getCategoryColor(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'paisaje':
        return const Color(0xFF2E7D32);
      case 'playa':
        return const Color(0xFF0277BD);
      case 'cultural':
        return const Color(0xFF6A1B9A);
      case 'hotel':
        return const Color(0xFFE65100);
      case 'cultura':
        return const Color(0xFF6A1B9A);
      case 'tecnología':
        return const Color(0xFF1565C0);
      case 'deportes':
        return const Color(0xFFC62828);
      default:
        return const Color(0xFF37474F);
    }
  }

  IconData _getCategoryIcon(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'paisaje':
        return Icons.landscape;
      case 'playa':
        return Icons.beach_access;
      case 'cultural':
      case 'cultura':
        return Icons.account_balance;
      case 'hotel':
        return Icons.hotel;
      case 'tecnología':
        return Icons.devices;
      case 'deportes':
        return Icons.sports_soccer;
      default:
        return Icons.article;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryColor = _getCategoryColor(widget.articulo.tipo);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero Header Image
              SliverToBoxAdapter(
                child: _buildHeroHeader(categoryColor),
              ),
              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      // Category Chip
                      _buildCategoryChip(categoryColor),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        widget.articulo.titulo,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Stats Row
                      _buildStatsRow(),
                      const SizedBox(height: 20),
                      // Description
                      if (widget.articulo.descripcion.isNotEmpty)
                        _buildDescriptionSection(colorScheme),
                      const SizedBox(height: 28),
                      // Reviews section divider
                      _buildSectionHeader(
                        'Reseñas',
                        '${_reviews.length} reseñas',
                        colorScheme,
                      ),
                      const SizedBox(height: 16),
                      // Review form
                      if (_showReviewForm) _buildReviewForm(colorScheme),
                      // Reviews list
                      if (_reviews.isEmpty && !_showReviewForm)
                        _buildEmptyReviews(colorScheme),
                      ..._reviews.map((r) => _buildReviewCard(r, colorScheme)),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            child: ScaleTransition(
              scale: _fabAnimation,
              child: _buildCircleButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
          // Floating save button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: ScaleTransition(
              scale: _fabAnimation,
              child: ScaleTransition(
                scale: _heartScale,
                child: _buildCircleButton(
                  icon: _isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  iconColor: _isSaved ? Colors.red : Colors.white,
                  onTap: _toggleSaved,
                ),
              ),
            ),
          ),
        ],
      ),
      // FAB to write review
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton.extended(
          onPressed: () => setState(() => _showReviewForm = !_showReviewForm),
          backgroundColor: categoryColor,
          foregroundColor: Colors.white,
          elevation: 8,
          icon: Icon(_showReviewForm ? Icons.close_rounded : Icons.rate_review_rounded),
          label: Text(
            _showReviewForm ? 'Cancelar' : 'Reseñar',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroHeader(Color categoryColor) {
    return Hero(
      tag: 'articulo-${widget.articulo.id}',
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              categoryColor.withOpacity(0.8),
              categoryColor,
              categoryColor.withOpacity(0.6),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.07,
                child: Icon(
                  _getCategoryIcon(widget.articulo.tipo),
                  size: 300,
                  color: Colors.white,
                ),
              ),
            ),
            // Large center icon
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _getCategoryIcon(widget.articulo.tipo),
                      size: 54,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom fade
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.grey[50]!,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildCategoryChip(Color categoryColor) {
    return Container(
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: categoryColor.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getCategoryIcon(widget.articulo.tipo), size: 16, color: categoryColor),
          const SizedBox(width: 6),
          Text(
            widget.articulo.tipo.toUpperCase(),
            style: TextStyle(
              color: categoryColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final avgRating = _reviews.isEmpty
        ? 0.0
        : _reviews.map((r) => r.rating).reduce((a, b) => a + b) / _reviews.length;

    return Row(
      children: [
        Icon(Icons.star_rounded, color: CondorAppTheme.condorStarActive, size: 20),
        const SizedBox(width: 4),
        Text(
          _reviews.isEmpty ? 'Sin reseñas' : avgRating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 12),
        Text(
          '(${_reviews.length} ${_reviews.length == 1 ? 'reseña' : 'reseñas'})',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acerca de este lugar',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.articulo.descripcion,
            style: TextStyle(
              fontSize: 15,
              color: colorScheme.onSurface.withOpacity(0.75),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewForm(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tu calificación',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => _newRating = index + 1),
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    Icons.star_rounded,
                    size: 34,
                    color: index < _newRating
                        ? CondorAppTheme.condorStarActive
                        : colorScheme.outlineVariant,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _commentController,
            maxLines: 3,
            style: TextStyle(color: colorScheme.onSurface),
            cursorColor: colorScheme.primary,
            decoration: InputDecoration(
              hintText: 'Escribe tu opinión sobre este lugar...',
              hintStyle: TextStyle(color: colorScheme.outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.primary, width: 2),
              ),
              filled: true,
              fillColor: colorScheme.surfaceVariant.withOpacity(0.4),
              contentPadding: const EdgeInsets.all(14),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text(
                'Publicar reseña',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyReviews(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.rate_review_outlined, size: 56, color: colorScheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'Sé el primero en reseñar',
              style: TextStyle(
                color: colorScheme.outline,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review review, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    review.name.isNotEmpty ? review.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) => Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: i < review.rating
                            ? CondorAppTheme.condorStarActive
                            : colorScheme.outlineVariant,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              review.comment,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
