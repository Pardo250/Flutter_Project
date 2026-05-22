/// Modelo de datos que representa una notificación en la aplicación.
/// Mapea de forma directa los campos de la clase original `Notification.kt` de Android.
class NotificationModel {
  final String id;
  final String userName;
  final String action;
  final String time;
  final String avatarUrl;
  final String type; // "like" | "follow"
  final int createdAt;

  NotificationModel({
    this.id = '',
    this.userName = '',
    this.action = '',
    this.time = '',
    this.avatarUrl = '',
    this.type = 'like',
    this.createdAt = 0,
  });

  /// Factory para construir el modelo a partir de JSON/Map de Firestore.
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      action: json['action'] ?? '',
      time: json['time'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      type: json['type'] ?? 'like',
      createdAt: json['createdAt'] ?? 0,
    );
  }

  /// Método para convertir la instancia en Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'action': action,
      'time': time,
      'avatarUrl': avatarUrl,
      'type': type,
      'createdAt': createdAt,
    };
  }
}
