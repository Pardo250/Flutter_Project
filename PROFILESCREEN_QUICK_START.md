# 🚀 Quick Start - ProfileScreen Flutter

## ¡Ya Está Implementada! ✨

Tu pantalla ProfileScreen de Android Studio ahora está disponible en Flutter.

## Ejecutar la Pantalla

```bash
flutter run
```

La pantalla ProfileScreen se cargará como pantalla principal.

## Cambiar Pantalla Principal

Edita `lib/main.dart` y cambia `home:`:

```dart
// Para ProfileScreen (actual)
home: const ProfileScreen(),

// Para HomeScreen
home: const HomeScreen(),

// Para FeedScreen
home: const FeedScreen(),

// Para LoginScreen
home: const LoginScreen(),
```

## 👤 Componentes Principales

| Componente | Qué Hace |
|---|---|
| **ProfileImage** | Imagen de perfil circular |
| **ProfileHeader** | Nombre, username, badges, seguidores |
| **ProfileActions** | Botones editar y compartir |
| **MyReviewItem** | Tarjeta de reseña con editar/eliminar |
| **EditReviewDialog** | Diálogo para editar reseña |

## 📊 Datos de Ejemplo

- **Perfil**: Juan Pérez (@juanperez)
- **Imagen**: Avatar circular (fallback con ícono)
- **Badges**: ⭐ Top Reviewer
- **Seguidores**: 150
- **Siguiendo**: 42
- **Reseñas**: 3 ejemplos
- **Guardados**: 3 artículos

## 🎯 Funcionalidades

### Editar Reseña
1. En "Mis Reseñas", haz click en botón "Editar"
2. Se abre diálogo
3. Modifica calificación (estrellas) o comentario
4. Haz click en "Guardar"

### Eliminar Reseña
1. En "Mis Reseñas", haz click en botón "Eliminar"
2. Confirma la eliminación
3. La reseña desaparece

### Ver Tabs
- **Mis Reseñas**: Tus reseñas propias
- **Guardados**: Artículos que guardaste

### Seguidores/Siguiendo
- Clickeable (próximamente ir a lista)

## 🎨 Personalizar Datos

Edita `_initializeProfileData()` en `lib/screens/profile_screen.dart`:

```dart
uiState = ProfileUiState(
  name: 'Tu Nombre',
  username: '@tunombre',
  imageUrl: 'https://ejemplo.com/avatar.jpg',
  followersCount: 100,
  followingCount: 50,
  isTopReviewer: true,
  isInfluencer: false,
  reviews: [
    Review(
      id: '1',
      name: 'Tu Nombre',
      rating: 5,
      comment: 'Mi comentario',
      articuloId: '1',
      articuloNombre: 'Nombre del Lugar',
    ),
  ],
  savedArticles: [
    Articulo(
      id: '1',
      titulo: 'Mi Artículo Guardado',
      descripcion: 'Descripción',
      tipo: 'paisaje',
    ),
  ],
);
```

## 🔗 Conectar con API

Reemplaza `_initializeProfileData()`:

```dart
@override
void initState() {
  super.initState();
  _loadProfile();
}

Future<void> _loadProfile() async {
  setState(() {
    uiState = uiState.copyWith(isLoading: true);
  });
  
  try {
    final response = await http.get(
      Uri.parse('tu-api.com/profile'),
    );
    
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

## 🎭 Badges

### ⭐ Top Reviewer
- Ícono dorado con borde dorado
- Usuario es un reseñador destacado

### ✓ Influencer
- Ícono azul verificado
- Usuario es influyente

Para activar badges:
```dart
isTopReviewer: true,  // Agregar estrella dorada
isInfluencer: true,   // Agregar verificación azul
```

## 📱 Estados Visuales

### Cargando
Spinner en el centro mientras se cargan datos.

### Error
Muestra mensaje de error si algo falla.

### Sin Reseñas
"Aún no has hecho reseñas." en tab "Mis Reseñas".

### Sin Guardados
"No tienes artículos guardados." en tab "Guardados".

## 🔀 Navegar Entre Pantallas

```dart
// Ir a ProfileScreen
Navigator.pushNamed(context, '/profile');

// Ir a HomeScreen
Navigator.pushNamed(context, '/home');

// Ir a FeedScreen
Navigator.pushNamed(context, '/feed');

// Volver atrás
Navigator.pop(context);
```

## 🖼️ ProfileImage Widget

Widget reutilizable que puedes usar en otras pantallas:

```dart
// En cualquier pantalla
ProfileImage(
  imageUrl: 'https://...',  // Opcional
  size: 80,                  // Opcional
)

// Soporta cualquier tamaño
ProfileImage(
  imageUrl: user.avatar,
  size: 150,  // Grande
)
```

## 🎨 Personalizar Colores

Edita `lib/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6200EE);
static const Color condorStarActive = Color(0xFFFDB022);
```

## 🧪 Edición de Reseña Localmente

El diálogo de edición funciona completamente en el cliente. Los cambios se reflejan inmediatamente:

```dart
// Al hacer click editar, se abre diálogo
// Cambias el rating (estrellas)
// Cambias el comentario
// Haces click "Guardar"
// ✅ La reseña se actualiza al instante
```

## 🗑️ Eliminación con Confirmación

Al hacer click eliminar:

```
¿Estás seguro de eliminar?
[Cancelar] [Eliminar]
```

Confirma para eliminar permanentemente.

## 📚 Archivos Clave

```
lib/
├── screens/profile_screen.dart    # Pantalla principal (500+ líneas)
├── models/profile_ui_state.dart   # Estado de ProfileScreen
├── widgets/profile_image.dart     # Widget ProfileImage
└── theme/app_theme.dart           # Colores y tema
```

## 🐛 Troubleshooting

### "Mi imagen de perfil no se ve"
- Si `imageUrl` está vacío o inválido, muestra ícono
- Verifica que la URL sea válida

### "Las reseñas no se guardan después de editar"
- Los cambios se guardan localmente al instante
- Para persistencia real, conecta con API
- Ver sección "Conectar con API"

### "El diálogo de edición no aparece"
- Haz click en botón "Editar" de una reseña
- El diálogo debe aparecer

### "No veo los tabs"
- Los tabs están debajo del header del perfil
- Scroll hacia abajo si no los ves

## 🎓 Próximos Pasos

1. ✅ ProfileScreen implementada
2. ⏳ Conectar con API real
3. ⏳ Agregar pantalla de editar perfil
4. ⏳ Agregar pantalla de followers/following
5. ⏳ Agregar sistema de favoritos
6. ⏳ Integrar con autenticación

## 🚀 Deployment

```bash
# Build APK (Android)
flutter build apk

# Build IPA (iOS)
flutter build ios

# Build Web
flutter build web
```

---

**¡ProfileScreen está lista para usar!** 🎉

Revisa `PROFILESCREEN_README.md` para más detalles.
