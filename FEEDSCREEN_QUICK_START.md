# 🚀 Quick Start - FeedScreen Flutter

## ¡Ya Está Implementada! ✨

Tu pantalla FeedScreen de Android Studio ahora está disponible en Flutter.

## Ejecutar la Pantalla

```bash
flutter run
```

La pantalla FeedScreen (exploración) se cargará como pantalla principal.

## Cambiar Pantalla Principal

Edita `lib/main.dart` y cambia `home:`:

```dart
// Para FeedScreen (actual)
home: const FeedScreen(),

// Para HomeScreen
home: const HomeScreen(),

// Para LoginScreen
home: const LoginScreen(),
```

## 🎨 Componentes Principales

| Componente | Qué Hace |
|---|---|
| **FeedSearchBar** | Barra de búsqueda funcional |
| **MapCard** | Tarjeta con mapa interactiva |
| **CategoryChips** | Filtros por categoría |
| **ArticuloGrid** | Grid de 2 columnas |
| **ArticuloGridCard** | Tarjeta individual de artículo |

## 📝 Categorías Disponibles

- 🏔️ **Paisajes** - Paisajes naturales
- 🏖️ **Playas** - Playas y costas
- 🏛️ **Cultural** - Sitios culturales e históricos
- 🏨 **Hoteles** - Alojamientos

## 🔍 Funcionalidades

### Búsqueda
Escribe en la barra para buscar en título y descripción del artículo.

### Categorías
Haz click en un chip para filtrar artículos por categoría.

### Grid
El grid muestra:
- Imagen del artículo (o inicial del tipo si no hay imagen)
- Título (máx 2 líneas)
- Badge con el tipo

## 📊 Datos de Ejemplo

La pantalla incluye 6 artículos:
1. Valle del Cocora (paisaje)
2. Playa Blanca (playa)
3. Centro Histórico (cultural)
4. Resort de Lujo (hotel)
5. Montañas Nevadas (paisaje)
6. Catedral Metropolitana (cultural)

## 🔄 Filtrado

El grid se filtra automáticamente por:
- Categoría seleccionada
- Texto de búsqueda

**Ejemplo**: Si seleccionas "Paisajes" y buscas "Valle", solo aparecerá "Valle del Cocora".

## 🎯 Personalizar Artículos

Edita `_initializeData()` en `lib/screens/feed_screen.dart`:

```dart
articulos = [
  Articulo(
    id: '1',
    titulo: 'Mi Artículo',
    descripcion: 'Descripción del lugar',
    tipo: 'paisaje', // tipo: paisaje, playa, cultural, hotel
    imagenUrl: 'https://ejemplo.com/imagen.jpg',
  ),
  // ... más artículos
];
```

## 🔗 Conectar con API

Reemplaza `_initializeData()`:

```dart
@override
void initState() {
  super.initState();
  _loadData();
}

Future<void> _loadData() async {
  setState(() => isLoading = true);
  try {
    final response = await http.get(Uri.parse('tu-api.com/articulos'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        articulos = List<Articulo>.from(
          data['articulos'].map((a) => Articulo.fromJson(a))
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

## 🎭 Estados Visuales

### Loading (Cargando)
Aparece un spinner mientras se cargan los datos.

### Error
Si hay un error, se muestra el mensaje.

### Empty (Vacío)
Si no hay artículos que coincidan con los filtros, aparece "No se encontraron artículos".

## 🗺️ Tarjeta de Mapa

La tarjeta de mapa muestra un icono de mapa y un botón "Ver reviews en el mapa".

**Personalizar**:
```dart
void _onMapClick() {
  // Navegar a pantalla de mapa
  Navigator.pushNamed(context, '/mapa');
}
```

## 🔀 Navegar Entre Pantallas

### Con Rutas
```dart
// Ir a HomeScreen
Navigator.pushNamed(context, '/home');

// Ir a FeedScreen
Navigator.pushNamed(context, '/feed');

// Ir a LoginScreen
Navigator.pushNamed(context, '/login');
```

### Con Botones

Agrega un `FloatingActionButton` o `AppBar` con navegación:

```dart
AppBar(
  title: const Text('Explorar'),
  actions: [
    IconButton(
      icon: const Icon(Icons.home),
      onPressed: () => Navigator.pushNamed(context, '/home'),
    ),
  ],
)
```

## 📱 Tamaños de Grid

El grid está configurado para:
- **2 columnas** en todos los tamaños
- **Spacing**: 12dp entre items
- **Aspect Ratio**: 0.85 (más alto que ancho)

Para cambiar:
```dart
SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 3, // Cambiar a 3 columnas
  childAspectRatio: 1.0, // Cambiar proporción
)
```

## 🎨 Personalizar Colores

Edita `lib/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6200EE);  // Color principal
static const Color condorStarActive = Color(0xFFFDB022); // Estrellas
```

## 🐛 Troubleshooting

### Grid vacío
- Verifica que los artículos tengan el tipo correcto
- Prueba sin filtro (borra búsqueda y categoría)

### Imágenes no cargan
- Las URLs deben ser válidas y accesibles
- Si `imagenUrl` está vacío, se muestra la inicial

### Búsqueda no funciona
- Asegúrate de escribir correctamente
- La búsqueda es en título y descripción

## 📚 Documentación Completa

- **FEEDSCREEN_README.md** - Guía detallada
- **FEEDSCREEN_MAPPING.md** - Android ↔ Flutter mapping
- **NAVIGATION_GUIDE.md** - Cómo navegar entre pantallas
- **QUICK_START.md** - Para HomeScreen

## 🎓 Próximos Pasos

1. Conectar con API real
2. Agregar pantalla de detalles del artículo
3. Agregar BottomNavigationBar para HomeScreen ↔ FeedScreen
4. Implementar búsqueda avanzada
5. Agregar favoritos

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

**¡FeedScreen está lista para usar!** 🎉

Revisa `FEEDSCREEN_README.md` para más detalles.
