# HomeScreen Implementation Guide

## Overview

Se ha implementado la pantalla `HomeScreen` de Flutter equivalente al código Android Studio que proporcionaste. La pantalla incluye todas las características principales del diseño original en Jetpack Compose.

## Estructura de Archivos

```
lib/
├── main.dart                 # Punto de entrada (actualizado)
├── theme/
│   └── app_theme.dart       # Tema personalizado con colores
├── models/
│   ├── articulo.dart        # Modelo para artículos
│   └── review.dart          # Modelo para reseñas
└── screens/
    ├── home_screen.dart     # Pantalla HomeScreen (NUEVA)
    ├── login_screen.dart    # Pantalla de login existente
    └── register_screen.dart # Pantalla de registro existente
```

## Componentes Principales

### 1. **HomeScreen** (Widget Principal)
- Maneja el estado de la pantalla (articulos, reviews, filtros, loading, etc.)
- Renderiza la lista de artículos con soporte para filtrado
- Gestiona la selección de artículos

### 2. **HomeHeader**
- Botón de navegación atrás
- Avatar del usuario
- Botón de notificaciones
- Barra de filtros

### 3. **ProfileAvatar**
- Avatar circular del usuario
- Maneja errores de carga de imagen

### 4. **FilterBar**
- Barra de filtros con logo y texto

### 5. **ArticuloCard**
- Tarjeta con imagen, título, descripción y tipo
- Soporta estado seleccionado
- Mostrado en lista con scroll

### 6. **HomeToggle**
- Toggle entre "Todos" y "Siguiendo"
- Filtra artículos basados en reseñas

### 7. **ReviewCardHome**
- Tarjeta compacta de reseña con avatar, nombre, calificación y comentario
- Estrellas de calificación

## Modelos de Datos

### Articulo
```dart
Articulo(
  id: '1',
  titulo: 'Artículo de prueba',
  descripcion: 'Descripción...',
  tipo: 'cultura',
  imagenUrl: '', // URL de la imagen
)
```

### Review
```dart
Review(
  id: '1',
  name: 'Juan',
  rating: 5,
  comment: 'Excelente artículo',
  articuloId: '1',
  articuloNombre: 'Artículo de prueba',
)
```

## Características Implementadas

✅ Lista de artículos con scroll infinito
✅ Filtro "Todos" y "Siguiendo"
✅ Tarjetas de artículos con imagen, título y descripción
✅ Avatar circular del usuario
✅ Botón de notificaciones
✅ Manejo de estado de carga
✅ Mensaje de error
✅ Mensaje de lista vacía
✅ Tarjetas de reseña con calificación
✅ Tema personalizado (claro y oscuro)
✅ Responsive design

## Uso

Para navegar a la pantalla HomeScreen:

```dart
// Desde el main.dart (ya está configurado)
MaterialApp(
  home: const HomeScreen(),
)

// O usando rutas
Navigator.pushNamed(context, '/home');
```

## Datos de Ejemplo

La pantalla incluye datos de ejemplo en `_initializeData()`:
- 3 artículos de ejemplo
- 2 reseñas de ejemplo

Puedes reemplazar estos datos con llamadas a un API o base de datos.

## Personalización

### Cambiar colores
Edita `lib/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF6200EE);
static const Color condorStarActive = Color(0xFFFDB022);
```

### Agregar más artículos
En `_initializeData()`:
```dart
articulos.add(
  Articulo(
    id: '4',
    titulo: 'Nuevo artículo',
    descripcion: 'Descripción',
    tipo: 'tipo',
    imagenUrl: 'url',
  ),
);
```

### Conectar con API
Reemplaza `_initializeData()` con una llamada a tu API:
```dart
Future<void> _initializeData() async {
  setState(() => isLoading = true);
  try {
    final response = await http.get(Uri.parse('tu-api.com/articulos'));
    // Procesar respuesta
  } catch (e) {
    setState(() => errorMessage = e.toString());
  } finally {
    setState(() => isLoading = false);
  }
}
```

## Próximos Pasos

1. **Conectar API**: Integra con tu backend para obtener datos reales
2. **Agregar navegación**: Conecta el clic en artículos con la pantalla de detalles
3. **Agregar notificaciones**: Implementa la funcionalidad de notificaciones
4. **Agregar imágenes**: Coloca `assets/avatar.png` en tu carpeta de assets
5. **Mejorar el tema**: Personaliza colores y fuentes según tu diseño

## Notas

- La pantalla usa `CustomScrollView` con `SliverList` para mejor rendimiento
- El avatar del usuario intenta cargar desde `assets/avatar.png`, pero muestra un ícono por defecto si no existe
- Las imágenes de artículos se cargan desde URLs, con un icono de error si no se pueden cargar
- El estado se maneja localmente con `setState`, consideraremos migrar a un gestor de estado más robusto (Provider, Riverpod, etc.) si lo necesitas

## Troubleshooting

Si encuentras errores:

1. Asegúrate de que todos los archivos estén en las rutas correctas
2. Ejecuta `flutter pub get` para actualizar dependencias
3. Ejecuta `flutter clean && flutter pub get` si persisten problemas
4. Verifica que las imágenes tengan URLs válidas

---

**¡Implementación completada!** 🎉 La pantalla HomeScreen está lista para usar en tu proyecto Flutter.
