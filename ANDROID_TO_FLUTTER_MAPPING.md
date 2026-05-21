# Android Compose → Flutter Mapping

## Comparativa de Componentes

| Componente Android | Componente Flutter | Ubicación |
|---|---|---|
| `HomeScreenRoute()` | `HomeScreen` (StatefulWidget) | `home_screen.dart` |
| `HomeScreenContent()` | `HomeScreen.build()` con `CustomScrollView` | `home_screen.dart` |
| `HomeHeader()` | `HomeHeader` | `home_screen.dart` |
| `ProfileAvatar()` | `ProfileAvatar` | `home_screen.dart` |
| `FilterBar()` | `FilterBar` | `home_screen.dart` |
| `ArticuloCard()` | `ArticuloCard` | `home_screen.dart` |
| `HomeToggle()` | `HomeToggle` + `_ToggleOption` | `home_screen.dart` |
| `ReviewCardHome()` | `ReviewCardHome` | `home_screen.dart` |
| `Articulo` (data class) | `Articulo` (class) | `models/articulo.dart` |
| `Review` (data class) | `Review` (class) | `models/review.dart` |

## Mapeo de Composables a Widgets

### Layout
| Android | Flutter |
|---|---|
| `LazyColumn` | `CustomScrollView` con `SliverList` |
| `Column` | `Column` |
| `Row` | `Row` |
| `Box` | `Container` / `SizedBox` |
| `Card` | `Card` |

### UI Components
| Android | Flutter |
|---|---|
| `Icon` | `Icon` |
| `Text` | `Text` |
| `IconButton` | `IconButton` / `GestureDetector` |
| `CircularProgressIndicator` | `CircularProgressIndicator` |
| `Surface` | `Container` con `BoxDecoration` |
| `AsyncImage` | `Image.network` |

### Styling
| Android | Flutter |
|---|---|
| `modifier.fillMaxWidth()` | `crossAxisAlignment: CrossAxisAlignment.stretch` o `width: double.infinity` |
| `modifier.padding()` | `Padding` widget |
| `modifier.size()` | `SizedBox` / `Container` |
| `modifier.background()` | `Container` con `color` o `BoxDecoration` |
| `modifier.clip()` | `ClipRRect` / `ClipOval` |
| `RoundedCornerShape` | `BorderRadius.circular()` |
| `CircleShape` | `BoxShape.circle` |
| `colorScheme.primary` | `Theme.of(context).colorScheme.primary` |
| `FontWeight.Bold` | `FontWeight.bold` |
| `fontSize = 18.sp` | `fontSize: 18` |

### State Management
| Android | Flutter |
|---|---|
| `HomeViewModel` | Local `State` en `HomeScreen` |
| `collectAsStateWithLifecycle()` | `setState()` |
| `Flow<HomeUiState>` | Variables locales con `setState` |
| `hiltViewModel()` | Variables de instancia en `_HomeScreenState` |

## Funcionalidades Mapeadas

### 1. **Lista de Artículos**
```kotlin
// Android
LazyColumn {
    items(articlesToShow, key = { it.id }) { articulo ->
        ArticuloCard(...)
    }
}
```

```dart
// Flutter
SliverList(
    delegate: SliverChildBuilderDelegate(
        (context, index) {
            final articulo = articlesToShow[index];
            return ArticuloCard(...);
        },
        childCount: articlesToShow.length,
    ),
)
```

### 2. **Filtro Todos/Siguiendo**
```kotlin
// Android
onToggleFilter = viewModel::onToggleFilter,
```

```dart
// Flutter
onToggle: _toggleFilter,

void _toggleFilter(bool value) {
    setState(() => showFollowingOnly = value);
}
```

### 3. **Carga de Imagen**
```kotlin
// Android
AsyncImage(
    model = articulo.imagenUrl,
    contentDescription = articulo.titulo,
)
```

```dart
// Flutter
Image.network(
    articulo.imagenUrl,
    errorBuilder: (context, error, stackTrace) { ... }
)
```

### 4. **Tema de Color**
```kotlin
// Android
val colorScheme = MaterialTheme.colorScheme
colorScheme.primary
```

```dart
// Flutter
final colorScheme = Theme.of(context).colorScheme;
colorScheme.primary
```

## Principales Diferencias

### 1. State Management
- **Android**: ViewModel + Flow (Reactive)
- **Flutter**: setState (Imperative) - Consideraremos migrar a Provider/Riverpod

### 2. Lifecycle
- **Android**: Composable automáticamente recomposiciona
- **Flutter**: setState() requiere llamadas explícitas

### 3. Navegación
- **Android**: Hilt + Navigation Compose
- **Flutter**: Navigator.push() o rutas nombradas

### 4. Recolección de Datos
- **Android**: collectAsStateWithLifecycle()
- **Flutter**: Future/async-await o Streams

## Ejemplos de Uso

### Obtener ColorScheme
```dart
final colorScheme = Theme.of(context).colorScheme;
```

### Usar Tamaños
```dart
SizedBox(width: 80, height: 80)  // Flutter (sin .dp)
```

### Crear un Container Redondeado
```dart
Container(
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
    ),
)
```

### Iterar sobre una lista
```dart
// Android
repeat(5) { i -> ... }

// Flutter
List.generate(5, (index) => ...)
```

## Siguientes Pasos para Migración Completa

1. **State Management**: Migrar a Provider o Riverpod
2. **Network**: Agregar integración con API
3. **Navigation**: Conectar todas las rutas
4. **Testing**: Agregar pruebas unitarias y de widget
5. **Assets**: Agregar imágenes y otros recursos

---

**Nota**: Esta es una traducción directa del código Compose. La arquitectura puede optimizarse usando patrones de Flutter más avanzados según tus necesidades.
