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

class _ArticuloDetalleScreenState extends State<ArticuloDetalleScreen> {
  bool _isSaved = false;
  late List<Review> _reviews;
  bool _showReviewForm = false;
  int _newRating = 5;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reviews = List<Review>.from(widget.reviews);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleSaved() {
    setState(() => _isSaved = !_isSaved);
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
        backgroundColor: CondorAppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
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
              child: _buildHeroImage(),
            ),
            SliverToBoxAdapter(
              child: _buildDestinationInfo(),
            ),
            SliverToBoxAdapter(
              child: _buildDescriptionSection(),
            ),
            SliverToBoxAdapter(
              child: _buildMapSection(),
            ),
            SliverToBoxAdapter(
              child: _buildReviewsHeader(),
            ),
            SliverToBoxAdapter(
              child: _buildReviewForm(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildReviewItem(_reviews[index]),
                childCount: _reviews.length,
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

  Widget _buildHeroImage() {
    return Stack(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.withValues(alpha: 0.5), Colors.green.withValues(alpha: 0.5)],
            ),
          ),
          child: const Center(
            child: Text('📸', style: TextStyle(fontSize: 80)),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.5),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: _toggleSaved,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.5),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                color: _isSaved ? CondorAppTheme.accentGold : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationInfo() {
    final avgRating = _reviews.isEmpty
        ? 4.8
        : _reviews.map((r) => r.rating).reduce((a, b) => a + b) / _reviews.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.articulo.titulo,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: CondorAppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: index < avgRating.toInt()
                                  ? CondorAppTheme.accentGold
                                  : Color(0xFF505050),
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${avgRating.toStringAsFixed(1)} (${_reviews.length} reseñas)',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: CondorAppTheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: CondorAppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CondorAppTheme.primaryGreen),
                ),
                child: Text(
                  widget.articulo.tipo.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CondorAppTheme.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acerca de este lugar',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: CondorAppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.articulo.descripcion,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CondorAppTheme.textSecondary,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ubicación',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: CondorAppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withValues(alpha: 0.3),
                  Colors.green.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: const Center(
              child: Icon(Icons.location_on, size: 60, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reseñas (${_reviews.length})',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: CondorAppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() => _showReviewForm = !_showReviewForm);
            },
            icon: Icon(_showReviewForm ? Icons.close : Icons.add),
            label: Text(_showReviewForm ? 'Cancelar' : 'Reseña'),
            style: ElevatedButton.styleFrom(
              backgroundColor: CondorAppTheme.primaryGreen,
              foregroundColor: CondorAppTheme.darkGreen,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewForm() {
    if (!_showReviewForm) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CondorAppTheme.cardBg,
          border: Border.all(color: Color(0xFF404040)),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deja tu reseña',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CondorAppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () => setState(() => _newRating = index + 1),
                  child: Icon(
                    Icons.star,
                    color: index < _newRating
                        ? CondorAppTheme.accentGold
                        : Color(0xFF505050),
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _commentController,
              maxLines: 3,
              style: const TextStyle(color: CondorAppTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'Comparte tu experiencia...',
                hintStyle: const TextStyle(color: CondorAppTheme.textTertiary),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CondorAppTheme.primaryGreen,
                  foregroundColor: CondorAppTheme.darkGreen,
                ),
                child: const Text('Publicar Reseña'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CondorAppTheme.cardBg,
          border: Border.all(color: Color(0xFF404040)),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CondorAppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < review.rating
                          ? CondorAppTheme.accentGold
                          : Color(0xFF505050),
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CondorAppTheme.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
