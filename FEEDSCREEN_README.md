# FeedScreen Implementation Guide

## Overview

Se ha implementado la pantalla `FeedScreen` de Flutter equivalente al código Android Compose que proporcionaste. Es una pantalla de exploración/feed que muestra artículos recomendados en un grid y permite búsqueda y filtrado por categorías.

## Características Principales

✅ Barra de búsqueda funcional  
✅ Tarjeta de mapa interactiva  
✅ Chips de categorías seleccionables  
✅ Grid de 2 columnas de artículos  
✅ Filtrado por búsqueda y categoría  
✅ Manejo de estados (loading, error, vacío)  
✅ Responsive design  
✅ Tema Material 3  

## Archivos

```
lib/screens/feed_screen.dart     # Pantalla FeedScreen (NUEVA - 400+ líneas)
lib/main.dart                     # Actualizado con ruta /feed
```

## Componentes

### 1. **FeedScreen** (StatefulWidget Principal)
- Gestiona estado de búsqueda, categoría seleccionada
- Maneja datos de artículos y categorías
- Filtra artículos por búsqueda y categoría

### 2. **FeedSearchBar**
- Barra de búsqueda con ícono
- Busca en título y descripción

### 3. **MapCard**
- Tarjeta con imagen de mapa
- Botón clickeable con overlay de texto
- Navega a pantalla de mapa

### 4. **CategoryChips**
- Row horizontal de chips de categorías
- Selección única
- Categorías: Paisajes, Playas, Cultural, Hoteles

### 5. **FilterChipItem**
- Chip individual seleccionable
- Cambio de color según estado

### 6. **ArticuloGrid**
- Grid de 2 columnas
- Espacio de 12dp entre items
- Soporta lista vacía

### 7. **ArticuloGridCard**
- Tarjeta de artículo en grid
- Imagen con fallback (inicial del tipo)
- Título y badge de tipo
- Clickeable

## Datos de Ejemplo

La pantalla incluye 6 artículos de ejemplo:
- Valle del Cocora (paisaje)
- Playa Blanca (playa)
- Centro Histórico (cultural)
- Resort de Lujo (hotel)
- Montañas Nevadas (paisaje)
- Catedral Metropolitana (cultural)

## Filtrado

### Por Categoría
Filtra artículos por el tipo que comienza con la primera letra de la categoría:
- Paisajes → tipos que empiezan con 'p'
- Playas → tipos que empiezan con 'p'
- Cultural → tipos que empiezan con 'c'
- Hoteles → tipos que empiezan con 'h'

### Por Búsqueda
Busca en el título y descripción (case-insensitive)

## Modelo de Datos

```dart
Articulo(
  id: '1',
  titulo: 'Valle del Cocora',
  descripcion: 'Hermoso paisaje',
  tipo: 'paisaje',
  imagenUrl: 'https://...', // Opcional
)
```

## Uso

Para navegar a FeedScreen:

```dart
// Desde main.dart (ya está configurado como home)
home: const FeedScreen(),

// O usando rutas
Navigator.pushNamed(context, '/feed');
```

## Personalización

### Cambiar categorías
En `_initializeData()`:
```dart
static const List<String> _categoryNames = [
  'Paisajes',
  'Playas',
  'Cultural',
  'Hoteles',
];
```

### Agregar más artículos
```dart
articulos.add(
  Articulo(
    id: '7',
    titulo: 'Nuevo lugar',
    descripcion: 'Descripción',
    tipo: 'tipo',
    imagenUrl: 'url',
  ),
);
```

### Conectar con API
```dart
Future<void> _loadData() async {
  setState(() => isLoading = true);
  try {
    final response = await http.get(Uri.parse('tu-api.com/articulos'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        articulos = List<Articulo>.from(
            data.map((a) => Articulo.fromJson(a))
        );
      });
    }
  } catch (e) {
    setState(() => errorMessage = e.toString());
  } finally {
    setState(() => isLoading = false);
  }
}
```

## Diferencias con Android

| Android | Flutter |
|---|---|
| `LazyVerticalGrid` | `GridView.builder` |
| `OutlinedTextField` | `TextField` con `InputDecoration` |
| `AsyncImage` | `Image.network` con `errorBuilder` |
| `ViewModel` | Local `State` |
| `stringResource()` | String literal |

## Siguiente Paso

Para cambiar entre pantallas, actualiza `home:` en `main.dart`:

```dart
// Para HomeScreen
home: const HomeScreen(),

// Para FeedScreen
home: const FeedScreen(),

// Para LoginScreen
home: const LoginScreen(),
```

O usa navegación con rutas:
```dart
Navigator.pushNamed(context, '/feed');
Navigator.pushNamed(context, '/home');
Navigator.pushNamed(context, '/login');
```

## Troubleshooting

- **Grid vacío**: Verifica que los artículos cumplan con el filtro actual
- **Imágenes no cargan**: Las URL deben ser válidas, usa fallback con inicial
- **Categorías no filtran**: Asegúrate que el `tipo` del artículo coincida con la categoría

---

**¡FeedScreen está lista para usar!** 🎉
