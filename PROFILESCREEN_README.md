# ProfileScreen Implementation Guide

## Overview

Se ha implementado la pantalla `ProfileScreen` de Flutter equivalente al código Android Compose que proporcionaste. Es una pantalla de perfil que muestra información del usuario, sus reseñas propias y artículos guardados.

## Características Principales

✅ Avatar con imagen de perfil
✅ Nombre, username y badges (Top Reviewer, Influencer)
✅ Contadores de seguidores/siguiendo
✅ Botones de editar y compartir perfil
✅ Tabs: "Mis Reseñas" y "Guardados"
✅ Lista de reseñas propias con opciones editar/eliminar
✅ Diálogo de edición de reseña con calificación y comentario
✅ Artículos guardados
✅ Manejo de estados (loading, error, vacío)
✅ Responsive design
✅ Tema Material 3

## Archivos Creados

```
lib/
├── models/
│   └── profile_ui_state.dart    # State de ProfileScreen
├── widgets/
│   └── profile_image.dart       # Widget ProfileImage reutilizable
└── screens/
    └── profile_screen.dart      # ProfileScreen (500+ líneas)
```

## Componentes Principales

### 1. **ProfileScreen** (StatefulWidget)
- Widget principal que gestiona todo el estado
- Maneja edición/eliminación de reseñas
- Maneja cambios de tabs
- Inicializa datos de perfil

### 2. **ProfileScreenContent** (Stateless)
- Renderiza el contenido con CustomScrollView
- Usa SliverAppBar para el header
- Muestra tabs con TabBar
- Renderiza reseñas o artículos guardados

### 3. **ProfileHeader**
- Avatar circular con soporte para imagen o fallback
- Nombre, username con badges
- Contadores de seguidores/siguiendo
- Clickeables para ver listas

### 4. **ProfileActions**
- Botones "Editar Perfil" y "Compartir"
- Lado a lado con mismo tamaño

### 5. **MyReviewItem**
- Tarjeta con información de reseña
- Nombre del artículo reseñado
- Calificación con estrellas
- Comentario
- Botones editar/eliminar

### 6. **EditReviewDialog**
- Diálogo para editar reseña
- Selector de calificación (1-5 estrellas)
- Campo de texto para comentario
- Botones confirmar/cancelar

### 7. **ProfileImage** (Widget reutilizable)
- Muestra imagen de perfil en círculo
- Fallback con ícono si no hay imagen
- Soporte para diferentes tamaños

## Modelos de Datos

### ProfileUiState
```dart
ProfileUiState(
  name: String,
  username: String,
  imageUrl: String?,
  followersCount: int,
  followingCount: int,
  isTopReviewer: bool,
  isInfluencer: bool,
  reviews: List<Review>,
  savedArticles: List<Articulo>,
  isLoading: bool,
  errorMessage: String?,
  isShowingSaved: bool,
  isEditingReview: bool,
  editComment: String,
  editRating: int,
)
```

## Datos de Ejemplo

La pantalla incluye:
- Perfil: Juan Pérez (@juanperez)
- Badges: Top Reviewer
- Seguidores: 150
- Siguiendo: 42
- 3 reseñas propias
- 3 artículos guardados

## Funcionalidades

### Editar Reseña
1. Haz click en el botón "Editar" en una reseña
2. Se abre diálogo con calificación y comentario
3. Modifica los valores
4. Haz click en "Guardar"

### Eliminar Reseña
1. Haz click en el botón "Eliminar" en una reseña
2. Se muestra diálogo de confirmación
3. Confirma la eliminación

### Ver Followers/Following
1. Haz click en los números de seguidores o siguiendo
2. Navega a lista (a implementar)

### Tabs
1. Haz click en "Mis Reseñas" para ver tus reseñas
2. Haz click en "Guardados" para ver artículos guardados

## Personalización

### Cambiar datos del perfil
En `_initializeProfileData()` en `profile_screen.dart`:

```dart
uiState = ProfileUiState(
  name: 'Tu Nombre',
  username: '@tunombre',
  imageUrl: 'https://...',
  followersCount: 100,
  followingCount: 50,
  isTopReviewer: true,
  isInfluencer: false,
  // ... más datos
);
```

### Agregar/Editar reseñas
```dart
reviews: [
  Review(
    id: '1',
    name: 'Tu Nombre',
    rating: 5,
    comment: 'Comentario',
    articuloId: '1',
    articuloNombre: 'Nombre del Artículo',
  ),
]
```

## Diferencias con Android

| Android | Flutter |
|---|---|
| `ProfileViewModel` | Local `State` en `ProfileScreen` |
| `collectAsStateWithLifecycle()` | `setState()` |
| `hiltViewModel()` | Variables de instancia |
| `LazyColumn` | `CustomScrollView` con `Sliver*` |
| `OutlinedTextField` | `TextField` |
| `AlertDialog` | `AlertDialog` |

## Próximos Pasos

1. Conectar con API para cargar perfil real
2. Agregar funcionalidad de editar perfil
3. Agregar funcionalidad de compartir
4. Agregar pantalla de followers/following
5. Integrar con sistema de autenticación

## Uso

Para navegar a ProfileScreen:

```dart
// Desde main.dart (ya está configurado como home)
home: const ProfileScreen(),

// O usando rutas
Navigator.pushNamed(context, '/profile');

// O con clase directa
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProfileScreen()),
);
```

## Conectar con API

Reemplaza `_initializeProfileData()`:

```dart
Future<void> _loadProfile() async {
  setState(() {
    uiState = uiState.copyWith(isLoading: true);
  });
  
  try {
    final response = await http.get(Uri.parse('tu-api.com/profile'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        uiState = ProfileUiState(
          name: data['name'],
          username: data['username'],
          imageUrl: data['imageUrl'],
          followersCount: data['followersCount'],
          followingCount: data['followingCount'],
          isTopReviewer: data['isTopReviewer'],
          isInfluencer: data['isInfluencer'],
          reviews: List<Review>.from(
              data['reviews'].map((r) => Review.fromJson(r))
          ),
          savedArticles: List<Articulo>.from(
              data['savedArticles'].map((a) => Articulo.fromJson(a))
          ),
        );
      });
    }
  } catch (e) {
    setState(() {
      uiState = uiState.copyWith(
        errorMessage: e.toString(),
      );
    });
  } finally {
    setState(() {
      uiState = uiState.copyWith(isLoading: false);
    });
  }
}
```

## Estados

### Loading
Muestra un spinner mientras se cargan los datos.

### Error
Muestra mensaje de error si algo falla.

### Vacío (Mis Reseñas)
"Aún no has hecho reseñas." si no hay reseñas.

### Vacío (Guardados)
"No tienes artículos guardados." si no hay artículos.

## Badges

### Top Reviewer ⭐
- Icono dorado con borde dorado
- Indica que es un reseñador destacado

### Influencer ✓
- Icono azul con borde azul (verificado)
- Indica que es un influencer

## Troubleshooting

### La imagen de perfil no aparece
- Si `imageUrl` está vacío, muestra ícono por defecto
- Verifica que la URL sea válida

### Las reseñas no se actualizan
- Haz click en "Guardar" en el diálogo
- Verifica que haya completado los campos

### Los tabs no funcionan
- Asegúrate de que `onTabSelected` cambie correctamente

---

**¡ProfileScreen está completa!** 🎉
