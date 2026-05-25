import 'package:flutter/material.dart';

/// Widget reutilizable para mostrar la imagen de perfil
class ProfileImage extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final String? fallbackInitial;

  const ProfileImage({
    super.key,
    this.imageUrl,
    this.size,
    this.fallbackInitial,
  });

  @override
  Widget build(BuildContext context) {
    final sizeValue = size ?? 120.0;

    return Container(
      width: sizeValue,
      height: sizeValue,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 3,
        ),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallback(context, sizeValue);
                },
              )
            : _buildFallback(context, sizeValue),
      ),
    );
  }

  Widget _buildFallback(BuildContext context, double sizeValue) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.primary.withValues(alpha: 0.1),
      child: Center(
        child: Icon(
          Icons.person,
          size: sizeValue * 0.5,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}
