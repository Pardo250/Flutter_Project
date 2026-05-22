import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedTab = 'Todo';
  bool _isLoading = false;

  // Lista en memoria de notificaciones (simulando base de datos)
  late List<NotificationModel> _notifications;

  // Set para guardar los IDs de usuarios que hemos seguido de vuelta
  final Set<String> _followedUserIds = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _notifications = [
      NotificationModel(
        id: '1',
        userName: 'María Gómez',
        action: 'le gustó tu reseña de Valle del Cocora',
        time: 'hace 5 min',
        avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
        type: 'like',
        createdAt: DateTime.now().millisecondsSinceEpoch - 300000,
      ),
      NotificationModel(
        id: '2',
        userName: 'Carlos López',
        action: 'empezó a seguirte',
        time: 'hace 10 min',
        avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
        type: 'follow',
        createdAt: DateTime.now().millisecondsSinceEpoch - 600000,
      ),
      NotificationModel(
        id: '3',
        userName: 'Sofía Rodríguez',
        action: 'le gustó tu reseña de Playa Blanca',
        time: 'hace 2 horas',
        avatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
        type: 'like',
        createdAt: DateTime.now().millisecondsSinceEpoch - 7200000,
      ),
      NotificationModel(
        id: '4',
        userName: 'Alejandro Torres',
        action: 'empezó a seguirte',
        time: 'hace 1 día',
        avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        type: 'follow',
        createdAt: DateTime.now().millisecondsSinceEpoch - 86400000,
      ),
      NotificationModel(
        id: '5',
        userName: 'Ana Martínez',
        action: 'le gustó tu reseña de Centro Histórico',
        time: 'hace 3 días',
        avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
        type: 'like',
        createdAt: DateTime.now().millisecondsSinceEpoch - 259200000,
      ),
    ];
  }

  /// Cambia la pestaña seleccionada y actualiza el filtro de notificaciones
  void _onTabSelected(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  /// Simula la limpieza de notificaciones con un loading que imita a Firestore
  void _onClearAll() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _notifications.clear();
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notificaciones limpiadas con éxito'),
            backgroundColor: Color(0xFF1B5E20),
          ),
        );
      }
    });
  }

  /// Filtra la lista de notificaciones según el tipo
  List<NotificationModel> get _filteredNotifications {
    switch (_selectedTab) {
      case 'Likes':
        return _notifications.where((n) => n.type == 'like').toList();
      case 'Followers':
        return _notifications.where((n) => n.type == 'follow').toList();
      default:
        return _notifications; // 'Todo'
    }
  }

  /// Alterna el estado de seguimiento del usuario
  void _toggleFollow(String userId) {
    setState(() {
      if (_followedUserIds.contains(userId)) {
        _followedUserIds.remove(userId);
      } else {
        _followedUserIds.add(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filteredList = _filteredNotifications;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Top Bar
            _buildTopBar(context, colorScheme),
            const SizedBox(height: 20),
            // Filtros segmentados estilo píldora
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildTabs(colorScheme),
            ),
            const SizedBox(height: 20),
            // Contenido principal
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                      ),
                    )
                  : filteredList.isEmpty
                      ? Center(
                          child: Text(
                            'No tienes notificaciones',
                            style: TextStyle(
                              color: colorScheme.outline,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          itemCount: filteredList.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 18),
                          itemBuilder: (context, index) {
                            final notification = filteredList[index];
                            return _buildNotificationItem(
                              context,
                              colorScheme,
                              notification,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  /// Barra superior idéntica a NotificationTopBar en Compose
  Widget _buildTopBar(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        verticalAlignment: Alignment.centerVertically,
        children: [
          // Botón Atrás
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.secondaryContainer,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onSecondaryContainer,
                size: 20,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(width: 16),
          // Título
          Text(
            'Notificaciones',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const Spacer(),
          // Limpiar Todo
          if (_notifications.isNotEmpty)
            TextButton(
              onPressed: _onClearAll,
              child: Text(
                'Limpiar todo',
                style: TextStyle(
                  color: colorScheme.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Tabs estilo píldora idénticos a NotificationTabs en Compose
  Widget _buildTabs(ColorScheme colorScheme) {
    final tabs = ['Todo', 'Likes', 'Followers'];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = tab == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => _onTabSelected(tab),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  tab,
                  style: TextStyle(
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.medium,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Tarjeta de item individual idéntica a NotificationItem en Compose
  Widget _buildNotificationItem(
    BuildContext context,
    ColorScheme colorScheme,
    NotificationModel notification,
  ) {
    final isFollowingBack = _followedUserIds.contains(notification.id);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar Box (70dp x 70dp) con esquinas redondeadas 16dp
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: ClipOval(
            child: SizedBox(
              width: 48,
              height: 48,
              child: Image.network(
                notification.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: colorScheme.primary.withOpacity(0.15),
                    alignment: Alignment.center,
                    child: Text(
                      notification.userName.isNotEmpty
                          ? notification.userName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Columna con contenido textual y botón de acción
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fila con nombre de usuario y acción
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 15,
                        color: colorScheme.onSurface,
                      ),
                  children: [
                    TextSpan(
                      text: notification.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: notification.action,
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              // Botón si es tipo "follow" (Seguir También / Siguiendo)
              if (notification.type == 'follow') ...[
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () => _toggleFollow(notification.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFollowingBack
                          ? colorScheme.surfaceVariant
                          : colorScheme.primary,
                      foregroundColor: isFollowingBack
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      elevation: 0,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 0,
                      ),
                    ),
                    child: Text(
                      isFollowingBack ? 'Siguiendo' : 'Seguir También',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              // Tiempo de la notificación (alineado al final)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  notification.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
