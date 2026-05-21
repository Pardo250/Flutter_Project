import 'package:flutter/material.dart';
import '../models/articulo.dart';
import '../theme/app_theme.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String searchQuery = '';
  int selectedCategoryIndex = 0;
  bool isLoading = false;
  String? errorMessage;

  late List<Articulo> articulos;
  late List<String> categories;

  // Categorías disponibles
  static const List<String> _categoryNames = [
    'Paisajes',
    'Playas',
    'Cultural',
    'Hoteles',
  ];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    categories = _categoryNames;

    articulos = [
      Articulo(
        id: '1',
        titulo: 'Valle del Cocora',
        descripcion: 'Hermoso paisaje de palmeras',
        tipo: 'paisaje',
        imagenUrl: '',
      ),
      Articulo(
        id: '2',
        titulo: 'Playa Blanca',
        descripcion: 'Arena blanca y agua turquesa',
        tipo: 'playa',
        imagenUrl: '',
      ),
      Articulo(
        id: '3',
        titulo: 'Centro Histórico',
        descripcion: 'Arquitectura colonial colorida',
        tipo: 'cultural',
        imagenUrl: '',
      ),
      Articulo(
        id: '4',
        titulo: 'Resort de Lujo',
        descripcion: 'Hotel 5 estrellas frente al mar',
        tipo: 'hotel',
        imagenUrl: '',
      ),
      Articulo(
        id: '5',
        titulo: 'Montañas Nevadas',
        descripcion: 'Picos blancos y nieve perpetua',
        tipo: 'paisaje',
        imagenUrl: '',
      ),
      Articulo(
        id: '6',
        titulo: 'Catedral Metropolitana',
        descripcion: 'Monumento arquitectónico religioso',
        tipo: 'cultural',
        imagenUrl: '',
      ),
    ];
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  void _onSearchQueryChange(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  void _onArticuloClick(Articulo articulo) {
    Navigator.pushNamed(
      context,
      '/articulo_detalle',
      arguments: {
        'articulo': articulo,
        'reviews': [],
      },
    );
  }

  void _onMapClick() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ir a pantalla de mapa')),
    );
  }

  List<Articulo> get filteredArticulos {
    var filtered = articulos;

    // Filtrar por categoría
    if (selectedCategoryIndex >= 0 && selectedCategoryIndex < categories.length) {
      final category = categories[selectedCategoryIndex].toLowerCase();
      filtered = filtered
          .where((a) => a.tipo.toLowerCase().contains(category[0]))
          .toList();
    }

    // Filtrar por búsqueda
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((a) =>
              a.titulo.toLowerCase().contains(searchQuery.toLowerCase()) ||
              a.descripcion.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Search Bar
                FeedSearchBar(
                  query: searchQuery,
                  onQueryChange: _onSearchQueryChange,
                ),
                const SizedBox(height: 20),
                // Map Card
                MapCard(onClick: _onMapClick),
                const SizedBox(height: 20),
                // Category Chips
                CategoryChips(
                  selectedIndex: selectedCategoryIndex,
                  onSelected: _onCategorySelected,
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  'Recomendado para ti',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                // Loading
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                // Error
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                // Grid de artículos
                ArticuloGrid(
                  articulos: filteredArticulos,
                  onArticuloClick: _onArticuloClick,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Barra de búsqueda funcional
class FeedSearchBar extends StatelessWidget {
  final String query;
  final Function(String) onQueryChange;

  const FeedSearchBar({
    super.key,
    required this.query,
    required this.onQueryChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      value: query,
      onChanged: onQueryChange,
      decoration: InputDecoration(
        hintText: 'Buscar artículos...',
        hintStyle: TextStyle(
          color: colorScheme.outline.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: colorScheme.outline,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colorScheme.surfaceVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colorScheme.surfaceVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
    );
  }
}

/// Tarjeta con imagen del mapa. Al hacer click navega a la pantalla del mapa
class MapCard extends StatelessWidget {
  final VoidCallback onClick;

  const MapCard({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Map image fallback
              Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.map,
                  size: 80,
                  color: Colors.grey,
                ),
              ),
              // Overlay with text
              Positioned(
                bottom: 12,
                left: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface
                        .withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    '📍 Ver reviews en el mapa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Chips de categorías seleccionables
class CategoryChips extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelected;

  const CategoryChips({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Paisajes',
      'Playas',
      'Cultural',
      'Hoteles',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: EdgeInsets.only(right: 10, left: index == 0 ? 0 : 0),
            child: FilterChipItem(
              label: categories[index],
              selected: selectedIndex == index,
              onClick: () => onSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}

/// Chip individual de filtro de categoría
class FilterChipItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onClick;

  const FilterChipItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: selected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// Grid de artículos recomendados del backend
class ArticuloGrid extends StatelessWidget {
  final List<Articulo> articulos;
  final Function(Articulo) onArticuloClick;

  const ArticuloGrid({
    super.key,
    required this.articulos,
    required this.onArticuloClick,
  });

  @override
  Widget build(BuildContext context) {
    if (articulos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Center(
          child: Text(
            'No se encontraron artículos',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: articulos.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final articulo = articulos[index];
        return ArticuloGridCard(
          articulo: articulo,
          onClick: () => onArticuloClick(articulo),
        );
      },
    );
  }
}

/// Tarjeta individual de artículo en el grid con imagen, título y tipo
class ArticuloGridCard extends StatelessWidget {
  final Articulo articulo;
  final VoidCallback onClick;

  const ArticuloGridCard({
    super.key,
    required this.articulo,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: colorScheme.surface,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image or fallback
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: articulo.imagenUrl.isNotEmpty
                    ? Image.network(
                        articulo.imagenUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildImageFallback(colorScheme, articulo);
                        },
                      )
                    : _buildImageFallback(colorScheme, articulo),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    articulo.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Type badge
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      articulo.tipo,
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageFallback(ColorScheme colorScheme, Articulo articulo) {
    return Container(
      color: colorScheme.primary.withOpacity(0.1),
      child: Center(
        child: Text(
          articulo.tipo.isNotEmpty ? articulo.tipo[0].toUpperCase() : '?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
