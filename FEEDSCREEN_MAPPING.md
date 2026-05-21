# Comparativa FeedScreen: Android ↔ Flutter

## Estructura de Componentes

| Android Compose | Flutter | Archivo |
|---|---|---|
| `FeedScreenRoute()` | `FeedScreen` (StatefulWidget) | `feed_screen.dart` |
| `FeedScreenContent()` | `FeedScreen.build()` | `feed_screen.dart` |
| `FeedSearchBar()` | `FeedSearchBar` | `feed_screen.dart` |
| `MapCard()` | `MapCard` | `feed_screen.dart` |
| `CategoryChips()` | `CategoryChips` | `feed_screen.dart` |
| `FilterChipItem()` | `FilterChipItem` | `feed_screen.dart` |
| `ArticuloGrid()` | `ArticuloGrid` | `feed_screen.dart` |
| `ArticuloGridCard()` | `ArticuloGridCard` | `feed_screen.dart` |

## Mapeo de UI Elements

### Grid
```kotlin
// Android
LazyVerticalGrid(
    columns = GridCells.Fixed(2),
    verticalArrangement = Arrangement.spacedBy(12.dp),
    horizontalArrangement = Arrangement.spacedBy(12.dp),
)
```

```dart
// Flutter
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    childAspectRatio: 0.85,
  ),
)
```

### Search Bar
```kotlin
// Android
OutlinedTextField(
    value = query,
    onValueChange = onQueryChange,
    shape = RoundedCornerShape(28.dp),
    leadingIcon = { Icon(Icons.Default.Search, ...) }
)
```

```dart
// Flutter
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    prefixIcon: Icon(Icons.search),
  ),
)
```

### Category Chips
```kotlin
// Android
Row(horizontalArrangement = Arrangement.spacedBy(10.dp)) {
    categories.forEachIndexed { index, res ->
        FilterChipItem(...)
    }
}
```

```dart
// Flutter
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: List.generate(categories.length, (index) {
      return FilterChipItem(...);
    }),
  ),
)
```

### Map Card
```kotlin
// Android
Card(
    modifier = Modifier.fillMaxWidth().height(180.dp).clickable { onClick() }
) {
    Box {
        Image(...)
        Surface(...) { Text(...) }
    }
}
```

```dart
// Flutter
GestureDetector(
  onTap: onClick,
  child: Card(
    child: ClipRRect(
      child: Stack(
        children: [
          Image(...),
          Positioned(
            bottom: 12,
            left: 12,
            child: Container(...),
          ),
        ],
      ),
    ),
  ),
)
```

## Funcionalidades Mapeadas

### 1. Filtrado
```kotlin
// Android
val filteredArticulos = viewModel.uiState.filteredArticulos

// El ViewModel filtra por:
// - Búsqueda (titulo/descripcion)
// - Categoría seleccionada
```

```dart
// Flutter
List<Articulo> get filteredArticulos {
  var filtered = articulos;
  
  // Filtrar por categoría
  if (selectedCategoryIndex >= 0) {
    final category = categories[selectedCategoryIndex].toLowerCase();
    filtered = filtered.where((a) => 
      a.tipo.toLowerCase().contains(category[0])
    ).toList();
  }
  
  // Filtrar por búsqueda
  if (searchQuery.isNotEmpty) {
    filtered = filtered.where((a) =>
      a.titulo.toLowerCase().contains(searchQuery.toLowerCase()) ||
      a.descripcion.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }
  
  return filtered;
}
```

### 2. Selección de Categoría
```kotlin
// Android
onCategorySelected = viewModel::onCategorySelected
// En ViewModel cambia state
```

```dart
// Flutter
void _onCategorySelected(int index) {
  setState(() {
    selectedCategoryIndex = index;
  });
}
```

### 3. Búsqueda
```kotlin
// Android
onSearchQueryChange = viewModel::onSearchQueryChange
// En ViewModel actualiza query
```

```dart
// Flutter
void _onSearchQueryChange(String query) {
  setState(() {
    searchQuery = query;
  });
}
```

### 4. Click en Artículo
```kotlin
// Android
onArticuloClick = { articulo -> onPlaceClick(articulo.id) }
```

```dart
// Flutter
void _onArticuloClick(Articulo articulo) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Seleccionó: ${articulo.titulo}')),
  );
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
| LazyVerticalGrid | GridView.builder |
| Column | Column |
| Row | Row |
| Spacer() | SizedBox |

### Styling
| Android | Flutter |
|---|---|
| TextStyle + fontSize.sp | TextStyle + fontSize: 14 |
| color = colorScheme.primary | color: colorScheme.primary |
| RoundedCornerShape(20.dp) | BorderRadius.circular(20) |
| modifier.fillMaxWidth() | width: double.infinity |

## Patrones de Implementación

### Error Handling
```kotlin
// Android
state.errorMessage?.let { error ->
    Text(text = error, color = colorScheme.error)
}
```

```dart
// Flutter
if (errorMessage != null)
  Text(errorMessage!, style: TextStyle(color: Colors.red[700]))
```

### Empty State
```kotlin
// Android
if (articulos.isEmpty) {
    Text("No se encontraron artículos")
}
```

```dart
// Flutter
if (articulos.isEmpty) {
  Center(
    child: Text('No se encontraron artículos'),
  )
}
```

### Loading State
```kotlin
// Android
if (state.isLoading) {
    CircularProgressIndicator()
}
```

```dart
// Flutter
if (isLoading)
  CircularProgressIndicator()
```

## Optimizaciones

### Performance
- **Android**: LazyVerticalGrid renderiza items visibles
- **Flutter**: GridView.builder también renderiza items visibles
- Ambos son equivalentes en rendimiento

### Responsiveness
- **Android**: Modifier.fillMaxWidth()
- **Flutter**: width: double.infinity
- Resultado visual idéntico

## Ventajas de la Implementación Flutter

1. ✅ Menos boilerplate que ViewModel + Flow
2. ✅ Más fácil de entender para principiantes
3. ✅ Compilación más rápida
4. ✅ Misma look & feel con Material 3

## Mejoras Futuras

1. Migrar a Provider/Riverpod para separar lógica de UI
2. Agregar caché local de artículos
3. Implementar paginación en grid
4. Agregar animaciones de transición
5. Conectar con API real

---

**Nota**: Esta es una traducción directa funcional. Para aplicaciones en producción, se recomienda usar un gestor de estado más robusto (Provider, Riverpod, BLoC).
