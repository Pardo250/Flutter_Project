# 🚀 Quick Start - HomeScreen Flutter

## ¡Ya Está Implementado! ✨

Tu pantalla HomeScreen de Android Studio ahora está disponible en Flutter.

## Estructura del Proyecto

```
project_flutter/
├── lib/
│   ├── models/
│   │   ├── articulo.dart      ← Modelo de artículo
│   │   └── review.dart        ← Modelo de reseña
│   ├── theme/
│   │   └── app_theme.dart     ← Tema personalizado
│   ├── screens/
│   │   ├── home_screen.dart   ← 🏠 NUEVA PANTALLA (450+ líneas)
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   └── main.dart              ← Modificado (home por defecto)
├── HOMESCREEN_README.md       ← Documentación detallada
└── ANDROID_TO_FLUTTER_MAPPING.md ← Comparativa Android ↔ Flutter
```

## Ejecutar la Pantalla

```bash
# En la terminal del proyecto
flutter run

# La pantalla HomeScreen se abrirá automáticamente
```

## 🎨 Componentes Principales

| Componente | Qué Hace |
|---|---|
| **HomeScreen** | Pantalla principal, gestiona estado |
| **HomeHeader** | Avatar + Notificaciones + Botón atrás |
| **ArticuloCard** | Tarjeta con imagen, título y descripción |
| **HomeToggle** | Botones "Todos" y "Siguiendo" |
| **ReviewCardHome** | Tarjeta de reseña con estrellas |

## 📝 Datos de Ejemplo

La pantalla incluye 3 artículos y 2 reseñas de ejemplo.

Para agregar más, edita `_initializeData()` en `home_screen.dart`:

```dart
articulos.add(
  Articulo(
    id: '4',
    titulo: 'Mi Artículo',
    descripcion: 'Descripción',
    tipo: 'cultura',
    imagenUrl: 'https://...',
  ),
);
```

## 🔗 Conectar con tu API

Reemplaza `_initializeData()` en `home_screen.dart`:

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

## 🎯 Personalizar Colores

Edita `lib/theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6200EE);        // Cambiar color primario
static const Color condorStarActive = Color(0xFFFDB022);    // Color de estrellas
```

## 🔄 Flujo de Pantallas

```
LoginScreen → HomeScreen → Detalles del Artículo (TODO)
```

Actualmente el `main.dart` carga `HomeScreen`. Para cambiar a LoginScreen:

```dart
home: const LoginScreen(),  // Cambia aquí
```

## 📱 Responsive

La pantalla funciona en todos los tamaños:
- ✅ Celulares
- ✅ Tablets
- ✅ Orientación horizontal y vertical

## 🎭 Tema Claro/Oscuro

Ya está configurado en `main.dart`. Para cambiar:

```dart
themeMode: ThemeMode.dark,  // o ThemeMode.light, ThemeMode.system
```

## 🐛 Problemas Comunes

### "Image not found"
Las imágenes cargan desde URLs. Si `imagenUrl` está vacío, muestra un ícono.

### Avatar no aparece
El avatar intenta cargar desde `assets/avatar.png`. Si no existe, muestra un ícono. 

Para agregar imagen:
1. Crea carpeta `assets/` en la raíz
2. Agrega `avatar.png`
3. En `pubspec.yaml` agrega:
```yaml
flutter:
  assets:
    - assets/avatar.png
```

### Errores de compilación
```bash
flutter clean
flutter pub get
flutter run
```

## 📚 Documentación Completa

- **HOMESCREEN_README.md** - Guía detallada con todos los detalles
- **ANDROID_TO_FLUTTER_MAPPING.md** - Cómo se mapeó Android ↔ Flutter

## 🎓 Arquivos Clave

### Models
```dart
// lib/models/articulo.dart
Articulo(
  id: '1',
  titulo: 'Mi Artículo',
  descripcion: 'Descripción...',
  tipo: 'cultura',
  imagenUrl: 'https://...',
)

// lib/models/review.dart
Review(
  id: '1',
  name: 'Juan',
  rating: 5,
  comment: 'Excelente!',
  articuloId: '1',
  articuloNombre: 'Mi Artículo',
)
```

### Tema
```dart
// lib/theme/app_theme.dart
ThemeData lightTheme()   // Tema claro
ThemeData darkTheme()    // Tema oscuro
```

## 💡 Siguientes Mejoras

1. **State Management**: Migrar a Provider o Riverpod
2. **Navegación**: Conectar con pantalla de detalles
3. **API**: Integrar datos reales
4. **Notificaciones**: Implementar sistema de notificaciones
5. **Caché**: Agregar caché local con Hive

## 🚀 Deployment

```bash
# Build para Android
flutter build apk

# Build para iOS
flutter build ios

# Build para Web
flutter build web
```

---

**¡Tu pantalla HomeScreen está lista para usar!** 🎉

Revisa `HOMESCREEN_README.md` para más detalles.
