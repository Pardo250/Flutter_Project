# Comparativa ProfileScreen: Android ↔ Flutter

## Estructura de Componentes

| Android Compose | Flutter | Archivo |
|---|---|---|
| `ProfileScreenRoute()` | `ProfileScreen` (StatefulWidget) | `profile_screen.dart` |
| `ProfileScreenContent()` | `ProfileScreenContent` (Stateless) | `profile_screen.dart` |
| `ProfileTopBar()` | `SliverAppBar` | `profile_screen.dart` |
| `ProfileHeader()` | `ProfileHeader` | `profile_screen.dart` |
| `ProfileActions()` | `ProfileActions` | `profile_screen.dart` |
| `MyReviewItem()` | `MyReviewItem` | `profile_screen.dart` |
| `EditReviewDialog()` | `EditReviewDialog` | `profile_screen.dart` |
| `ProfileImage` | `ProfileImage` widget | `widgets/profile_image.dart` |

## Mapeo de UI Elements

### LazyColumn → CustomScrollView
```kotlin
// Android
LazyColumn(
    modifier = Modifier.fillMaxSize().padding(horizontal = 20.dp),
    contentPadding = PaddingValues(bottom = 120.dp)
) {
    item { ... }
    items(state.reviews) { ... }
}
```

```dart
// Flutter
CustomScrollView(
  slivers: [
    SliverAppBar(...),
    SliverToBoxAdapter(child: ...),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ...,
        childCount: state.reviews.length,
      ),
    ),
  ],
)
```

### TabRow
```kotlin
// Android
TabRow(
    selectedTabIndex = if (state.isShowingSaved) 1 else 0,
    containerColor = colorScheme.background,
) {
    Tab(...)
    Tab(...)
}
```

```dart
// Flutter
DefaultTabController(
  length: 2,
  initialIndex: state.isShowingSaved ? 1 : 0,
  child: TabBar(
    onTap: onTabSelected,
    tabs: [
      Tab(text: 'Mis Reseñas'),
      Tab(text: 'Guardados'),
    ],
  ),
)
```

### AlertDialog
```kotlin
// Android
AlertDialog(
    onDismissRequest = onDismiss,
    title = { Text(...) },
    text = { ... },
    confirmButton = { Button(...) },
)
```

```dart
// Flutter
AlertDialog(
  title: Text(...),
  content: Column(...),
  actions: [
    TextButton(...),
    ElevatedButton(...),
  ],
)
```

### Row (Followers/Following)
```kotlin
// Android
Row(horizontalArrangement = Arrangement.Center) {
    Column(...).clickable { onFollowListClick() }
    Column(...).clickable { onFollowListClick() }
}
```

```dart
// Flutter
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    GestureDetector(
      onTap: onFollowListClick,
      child: Column(...),
    ),
    GestureDetector(
      onTap: onFollowListClick,
      child: Column(...),
    ),
  ],
)
```

## Funcionalidades Mapeadas

### 1. Edición de Reseña
```kotlin
// Android
if (uiState.isEditingReview) {
    EditReviewDialog(...)
}

onConfirm = viewModel::confirmEditReview
```

```dart
// Flutter
if (uiState.isEditingReview)
  EditReviewDialog(...)

void _confirmEditReview() {
  // Actualizar reseña en lista
  // Actualizar estado
}
```

### 2. Eliminación de Reseña
```kotlin
// Android
onDeleteReview = viewModel::deleteReview
```

```dart
// Flutter
void _deleteReview(String reviewId) {
  showDialog(
    builder: (context) => AlertDialog(
      title: Text('Eliminar Reseña'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context)),
        TextButton(onPressed: () {
          // Eliminar
          // Actualizar estado
        }),
      ],
    ),
  );
}
```

### 3. Cambio de Tab
```kotlin
// Android
onTabSelected = viewModel::onTabSelected
// En ViewModel actualiza isShowingSaved
```

```dart
// Flutter
void _onTabSelected(int index) {
  setState(() {
    uiState = uiState.copyWith(isShowingSaved: index == 1);
  });
}
```

### 4. Carga de Perfil
```kotlin
// Android
LaunchedEffect(Unit) {
    viewModel.loadProfile()
}
```

```dart
// Flutter
@override
void initState() {
  super.initState();
  _initializeProfileData();
}
```

## Diferencias Clave

### State Management
| Android | Flutter |
|---|---|
| ViewModel + Flow | Local setState |
| collectAsStateWithLifecycle() | setState() |
| Reactive | Imperative |

### Composables vs Widgets
| Android | Flutter |
|---|---|
| Recomposition automática | rebuild() explícito |
| @Composable | Widget (build()) |
| modifier | properties |

### Layouts
| Android | Flutter |
|---|---|
| LazyColumn | CustomScrollView |
| Column | Column |
| Row | Row |
| Spacer | SizedBox |
| Card | Card |

### Styling
| Android | Flutter |
|---|---|
| colorScheme.primary | colorScheme.primary |
| RoundedCornerShape(12.dp) | BorderRadius.circular(12) |
| modifier.fillMaxWidth() | width: double.infinity |
| Icons.Default.Star | Icons.star |

## Patrones de Implementación

### Dialog con Campos Editables
```kotlin
// Android
OutlinedTextField(
    value = comment,
    onValueChange = onCommentChange,
)
```

```dart
// Flutter
TextField(
  controller: _commentController,
  onChanged: onCommentChange,
  decoration: InputDecoration(...),
)
```

### Calificación con Estrellas Interactivas
```kotlin
// Android
(1..5).forEach { star ->
    IconButton(
        onClick = { onRatingChange(star) },
    ) {
        Icon(
            tint = if (star <= rating) CondorStarActive
                  else colorScheme.outlineVariant
        )
    }
}
```

```dart
// Flutter
List.generate(
  5,
  (index) => IconButton(
    onPressed: () => setState(() => _currentRating = index + 1),
    icon: Icon(
      Icons.star,
      color: index < _currentRating ? activeColor : inactiveColor,
    ),
  ),
)
```

### Badges (Top Reviewer, Influencer)
```kotlin
// Android
if (isTopReviewer) {
    Surface(
        shape = CircleShape,
        color = Color(0xFFFFD700).copy(alpha = 0.2f),
        border = BorderStroke(1.dp, Color(0xFFFFD700))
    ) {
        Icon(Icons.Default.Star, tint = Color(0xFFFFD700))
    }
}
```

```dart
// Flutter
if (isTopReviewer)
  Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFFFD700).withOpacity(0.2),
      border: Border.all(color: Color(0xFFFFD700)),
    ),
    child: Icon(
      Icons.star,
      color: Color(0xFFFFD700),
    ),
  )
```

## Optimizaciones

### Performance
- **Android**: LazyColumn renderiza items visibles
- **Flutter**: SliverList también renderiza items visibles
- Ambos son equivalentes en rendimiento

### Memory
- **Android**: ViewModel gestiona estado fuera de Composable
- **Flutter**: State local en StatefulWidget
- Flutter usa menos memoria para esta pantalla simple

## Ventajas de la Implementación Flutter

1. ✅ Menos boilerplate que ViewModel + Flow
2. ✅ DialogFlow más simple con AlertDialog nativo
3. ✅ SliverAppBar automático con scroll
4. ✅ Edición de reseña completamente funcional
5. ✅ ProfileImage widget reutilizable

## Mejoras Futuras

1. Migrar a Provider/Riverpod para state management
2. Agregar caché local de perfil
3. Implementar sincronización con API
4. Agregar animaciones de transición
5. Agregar paginación en reseñas/guardados
6. Agregar compartir perfil a redes sociales

---

**Nota**: Esta es una traducción directa funcional. Para aplicaciones en producción, se recomienda usar un gestor de estado más robusto (Provider, Riverpod, BLoC).
